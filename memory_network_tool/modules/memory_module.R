# Memory Module - Simulates low-level memory management
MemoryBlock <- R6::R6Class("MemoryBlock", 
  public = list(
    address = NULL,
    size = NULL,
    data = NULL,
    allocated = FALSE,
    
    initialize = function(address, size) {
      self$address <- address
      self$size <- size
      self$data <- character(size)
      self$allocated <- FALSE
    },
    
    write = function(offset, value) {
      if (!self$allocated) {
        stop("Attempt to write to unallocated memory block")
      }
      if (offset < 0 || offset >= self$size) {
        stop("Memory write out of bounds")
      }
      self$data[offset + 1] <- value
    },
    
    read = function(offset) {
      if (!self$allocated) {
        stop("Attempt to read from unallocated memory block")
      }
      if (offset < 0 || offset >= self$size) {
        stop("Memory read out of bounds")
      }
      self$data[offset + 1]
    },
    
    get_status = function() {
      list(
        address = self$address,
        size = self$size,
        allocated = self$allocated,
        usage = sum(self$allocated) / self$size * 100
      )
    }
  )
)

MemoryManager <- R6::R6Class("MemoryManager", 
  public = list(
    blocks = list(),
    next_address = 0,
    
    initialize = function() {
      self$blocks <- list()
      self$next_address <- 0
    },
    
    allocate = function(size) {
      # Find a free block or create a new one
      for (i in seq_along(self$blocks)) {
        if (!self$blocks[[i]]$allocated) {
          self$blocks[[i]]$allocated <- TRUE
          return(self$blocks[[i]])
        }
      }
      
      # Create new block
      new_block <- MemoryBlock$new(self$next_address, size)
      new_block$allocated <- TRUE
      self$next_address <- self$next_address + size
      self$blocks[[length(self$blocks) + 1]] <- new_block
      return(new_block)
    },
    
    deallocate = function(block) {
      block$allocated <- FALSE
      cat(sprintf("Deallocated memory block at address %d\n", block$address))
    },
    
    get_block = function(address) {
      for (block in self$blocks) {
        if (block$address == address) {
          return(block)
        }
      }
      return(NULL)
    },
    
    get_status = function() {
      cat("=== Memory Status ===\n")
      for (block in self$blocks) {
        status <- block$get_status()
        cat(sprintf("Address: %d, Size: %d, Allocated: %s, Usage: %.2f%%\n", 
                    status$address, status$size, status$allocated, status$usage))
      }
    }
  )
)
