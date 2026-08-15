# Simulator Module - Orchestrates memory and network simulation
Simulator <- R6::R6Class("Simulator", 
  public = list(
    memory = NULL,
    network = NULL,
    running = FALSE,
    
    initialize = function() {
      self$memory <- MemoryManager$new()
      self$network <- list()
      self$running <- FALSE
    },
    
    initialize_network = function() {
      # Create network nodes
      node1 <- NetworkNode$new("192.168.1.1", 8080)
      node2 <- NetworkNode$new("192.168.1.2", 9090)
      node3 <- NetworkNode$new("192.168.1.3", 7070)
      
      self$network[[1]] <- node1
      self$network[[2]] <- node2
      self$network[[3]] <- node3
      
      cat("Network nodes created.\n")
      for (node in self$network) {
        node$connect()
      }
      cat("All network nodes connected.\n")
    },
    
    run = function() {
      self$running <- TRUE
      self$initialize_network()
      
      cat("\n=== Starting Simulation ===\n")
      
      # Allocate memory and create packets
      mem_block1 <- self$memory$allocate(10)
      mem_block2 <- self$memory$allocate(5)
      
      # Write data to memory
      for (i in 1:10) {
        mem_block1$write(i-1, sprintf("Data%d", i))
      }
      for (i in 1:5) {
        mem_block2$write(i-1, sprintf("Net%d", i))
      }
      
      # Create and send packets
      packet_data1 <- paste(mem_block1$data, collapse = ",")
      packet1 <- Packet$new("10.0.0.1", "10.0.0.2", 8080, packet_data1)
      self$network[[1]]$send_packet(packet1)
      
      packet_data2 <- paste(mem_block2$data, collapse = ",")
      packet2 <- Packet$new("10.0.0.2", "10.0.0.3", 9090, packet_data2)
      self$network[[2]]$send_packet(packet2)
      
      # Receive packets
      received1 <- self$network[[2]]$receive_packet()
      received2 <- self$network[[3]]$receive_packet()
      
      cat("\n=== Packet Reception ===\n")
      if (!is.null(received1)) {
        cat("Received packet at node 2: ")
        received1$get_header()
        cat("Data: ", paste(received1$data, collapse = ", "), "\n")
      }
      if (!is.null(received2)) {
        cat("Received packet at node 3: ")
        received2$get_header()
        cat("Data: ", paste(received2$data, collapse = ", "), "\n")
      }
      
      # Memory status
      cat("\n=== Memory Status ===\n")
      self$memory$get_status()
      
      # Network status
      cat("\n=== Network Status ===\n")
      for (node in self$network) {
        node$get_status()
      }
      
      # Deallocate memory
      self$memory$deallocate(mem_block1)
      self$memory$deallocate(mem_block2)
      
      self$running <- FALSE
    }
  )
)

new_simulator <- function() {
  return(Simulator$new())
}
