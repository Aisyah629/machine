# Network Module - Simulates low-level network protocol
Packet <- R6::R6Class("Packet", 
  public = list(
    src_ip = NULL,
    dst_ip = NULL,
    port = NULL,
    data = NULL,
    checksum = NULL,
    
    initialize = function(src_ip, dst_ip, port, data) {
      self$src_ip <- src_ip
      self$dst_ip <- dst_ip
      self$port <- port
      self$data <- data
      self$checksum <- self$calculate_checksum()
    },
    
    calculate_checksum = function() {
      sum(as.integer(charToRaw(paste(self$data, collapse = ",")))) %% 256
    },
    
    verify_checksum = function() {
      current_checksum <- self$calculate_checksum()
      return(current_checksum == self$checksum)
    },
    
    get_header = function() {
      cat(sprintf("Packet: Src=%s, Dst=%s, Port=%d, Checksum=%d\n", 
                  self$src_ip, self$dst_ip, self$port, self$checksum))
    }
  )
)

NetworkNode <- R6::R6Class("NetworkNode", 
  public = list(
    ip = NULL,
    port = NULL,
    connected = FALSE,
    buffer = NULL,
    
    initialize = function(ip, port) {
      self$ip <- ip
      self$port <- port
      self$connected <- FALSE
      self$buffer <- list()
    },
    
    connect = function() {
      self$connected <- TRUE
      cat(sprintf("Node %s:%d connected.\n", self$ip, self$port))
    },
    
    disconnect = function() {
      self$connected <- FALSE
      cat(sprintf("Node %s:%d disconnected.\n", self$ip, self$port))
    },
    
    send_packet = function(packet) {
      if (!self$connected) {
        stop("Node not connected")
      }
      if (!packet$verify_checksum()) {
        stop("Packet checksum verification failed")
      }
      self$buffer[[length(self$buffer) + 1]] <- packet
      cat(sprintf("Sent packet to %s:%d\n", self$ip, self$port))
    },
    
    receive_packet = function() {
      if (length(self$buffer) == 0) {
        return(NULL)
      }
      packet <- self$buffer[[1]]
      self$buffer <- self$buffer[-1]
      return(packet)
    },
    
    get_status = function() {
      cat(sprintf("Node %s:%d - Connected: %s, Packets in buffer: %d\n", 
                  self$ip, self$port, self$connected, length(self$buffer)))
    }
  )
)
