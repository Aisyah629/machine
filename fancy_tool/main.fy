import runtime::memory_manager
import runtime::concurrency
import runtime::gc

class RuntimeEnvironment
  class_variable @instance

  class <<new>
    RuntimeEnvironment @instance = RuntimeEnvironment new
  end

  class <<get>
    RuntimeEnvironment @instance
  end

  def initialize
    @memory_manager = memory_manager::Manager new
    @concurrency = concurrency::Manager new
    @gc = gc::GarbageCollector new
  end

  def allocate(size)
    @memory_manager allocate: size
  end

  def deallocate(pointer)
    @memory_manager deallocate: pointer
  end

  def spawn_thread(block)
    @concurrency spawn: block
  end

  def collect_garbage
    @gc collect
  end
end

module main
  runtime = RuntimeEnvironment get
  
  # Allocate some memory
  ptr = runtime allocate: 1024
  
  # Spawn a thread
  runtime spawn_thread do
    puts "Thread running"
  end
  
  # Collect garbage
  runtime collect_garbage
  
  # Deallocate memory
  runtime deallocate: ptr
end
