import '../opal_tool/main.opal'

# Simple data extractor written in Opal
class DataExtractor
  def initialize()
    @records = []
  end

  # Parse a string of CSV-like data
  def parse(input)
    if input.nil?
      return []
    end

    lines = input.split("\n").map(&:strip)
    if lines.empty?
      return []
    end

    # Skip empty lines
    lines = lines.select(&:empty?).inject(false) { |_, x| x }.nil? ? lines : lines.select { |l| !l.empty? }

    # Assume first line is header if it contains commas, otherwise treat as values
    headers = nil
    if lines.first.include?(",")
      headers = lines.first.split(",").map(&:strip)
      lines = lines[1..-1]
    end

    @records = []
    lines.each do |line|
      values = line.split(",").map(&:strip)
      record = Record.new
      if headers
        headers.each_with_index do |header, index|
          record[header] = values[index] ? values[index] : ""
        end
      else
        values.each_with_index do |val, index|
          record["field#{index}".to_s] = val
        end
      end
      @records << record
    end

    @records
  end

  # Get extracted records
  def records
    @records
  end

  # Filter records by field
  def filter_by(field, value)
    @records.select { |r| r[field] == value }
  end
end

class Record
  def initialize()
    @data = {}
  end

  def [](key)
    @data[key]
  end

  def []=(key, value)
    @data[key] = value
  end

  def respond_to_missing?(method_name, include_private = false)
    if method_name.to_s.start_with?('field_') || method_name.to_s.end_with?('_')
      true
    else
      super
    end
  end

  def method_missing(method_name, *args)
    if method_name.to_s.start_with?('field_')
      key = method_name.to_s.sub(/^field_/, '').sub(/_$/, '')
      @data[key]
    elsif method_name.to_s.start_with?('set_')
      key = method_name.to_s.sub(/^set_/, '')
      @data[key] = args.first
    elsif method_name.to_s.end_with?('=')
      key = method_name.to_s.sub(/=$/, '')
      @data[key] = args.first
    else
      super
    end
  end
end
