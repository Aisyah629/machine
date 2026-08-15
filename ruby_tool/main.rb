#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'logger'
require 'pathname'
require 'thread'

# Logger setup
$logger = Logger.new($stdout)
$logger.level = Logger::INFO

# Base class for pipeline stages
class PipelineStage
  attr_accessor :name

  def initialize(name)
    @name = name
    $logger.info "Stage initialized: #{name}"
  end

  def execute(data)
    raise NotImplementedError, "#{self.class} must implement #execute"
  end
end

# Example stage: Data Transformer
class DataTransformer < PipelineStage
  def execute(data)
    $logger.info "Transforming data"
    data.map do |item|
      item.is_a?(Hash) ? transform_hash(item) : item
    end
  end

  def transform_hash(hash)
    hash.transform_keys { |k| k.to_s.upcase }
  end
end

# Example stage: Filter
class FilterStage < PipelineStage
  def initialize(name, &block)
    super(name)
    @block = block
  end

  def execute(data)
    $logger.info "Filtering data"
    data.select { |item| @block.call(item) }
  end
end

# Pipeline Orchestrator
class PipelineOrchestrator
  def initialize
    @stages = []
    @logger = $logger
  end

  def add_stage(stage)
    @stages << stage
    @logger.info "Stage added to pipeline: #{stage.name}"
  end

  def run(input_data)
    @logger.info "Pipeline execution started"
    current_data = input_data.dup

    @stages.each do |stage|
      begin
        current_data = stage.execute(current_data)
        @logger.info "Stage #{stage.name} completed successfully"
      rescue StandardError => e
        @logger.error "Stage #{stage.name} failed: #{e.message}"
        raise
      end
    end

    @logger.info "Pipeline execution completed successfully"
    current_data
  end

  def clear
    @stages.clear
    @logger.info "Pipeline cleared"
  end
end

# Worker for concurrency
class WorkerPool
  def initialize(size)
    @size = size
    @workers = []
    @job_queue = Queue.new
    @results = []
    @mutex = Mutex.new
    @logger = $logger
  end

  def start
    @logger.info "Starting worker pool with #{@size} workers"
    @size.times do |i|
      worker = Thread.new do
        loop do
          job = @job_queue.pop
          break if job == :terminate
          process_job(job)
        end
      end
      @workers << worker
    end
  end

  def submit_job(job)
    @job_queue << job
  end

  def shutdown
    @logger.info "Shutting down worker pool"
    @size.times { @job_queue << :terminate }
    @workers.each(&:join)
  end

  private

  def process_job(job)
    begin
      result = job.call
      @mutex.synchronize { @results << result }
    rescue StandardError => e
      @logger.error "Job failed: #{e.message}"
    end
  end
end

# Main execution flow
if __FILE__ == $0
  # Example usage
  orchestrator = PipelineOrchestrator.new
  orchestrator.add_stage(DataTransformer.new('transform'))
  orchestrator.add_stage(FilterStage.new('filter') { |item| item.is_a?(Hash) })

  input_data = [
    { name: 'Alice', age: 30 },
    { name: 'Bob', age: 25 },
    'not a hash',
    { name: 'Charlie', age: 35 }
  ]

  result = orchestrator.run(input_data)
  puts "Pipeline Result: #{JSON.pretty_generate(result)}"

  # Example concurrency usage
  pool = WorkerPool.new(2)
  pool.start

  5.times do |i|
    pool.submit_job { sleep(rand(0.1..0.5)); "Job #{i} result" }
  end

  sleep(1) # Wait for jobs to finish
  pool.shutdown
  puts "Worker pool results: #{pool.instance_variable_get(:@results).inspect}"
end
