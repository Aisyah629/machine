// CPlus Tool - Low-level Memory Management and Network Protocol Simulator
// This is a pseudo-code implementation designed for the cplus_tool environment.
// It simulates a custom network protocol (SimNet) and low-level memory allocation.

// Define protocol constants
const HEADER_SIZE = 4;
const PAYLOAD_SIZE = 16;
const MAX_PACKETS = 64;
const BUFFER_SIZE = HEADER_SIZE + PAYLOAD_SIZE;

// Memory blocks
type MemBlock {
    address: int;
    size: int;
    allocated: bool;
}

// Packet structure
type Packet {
    header: int; // SimNet magic number
    payload: int[PAYLOAD_SIZE];
}

// Global state
mem_blocks: MemBlock[MAX_PACKETS];
free_list: int; // Index of the first free block
network_buffer: byte[BUFFER_SIZE];
packets_sent: int = 0;
packets_received: int = 0;

// Function: Initialize memory manager
func init_memory() {
    free_list = 0;
    for i in range(0, MAX_PACKETS) {
        mem_blocks[i].address = i * 100; // Base address for each block
        mem_blocks[i].size = 100;
        mem_blocks[i].allocated = false;
    }
    print("Memory initialized. Max blocks: " + MAX_PACKETS);
}

// Function: Allocate memory
func malloc(size: int) -> int {
    for i in range(0, MAX_PACKETS) {
        if mem_blocks[i].size >= size and mem_blocks[i].allocated == false {
            mem_blocks[i].allocated = true;
            print("Allocated block at address: " + mem_blocks[i].address + " size: " + mem_blocks[i].size);
            return mem_blocks[i].address;
        }
    }
    print("Allocation failed. Size: " + size);
    return -1; // Failure
}

// Function: Free memory
func free(address: int) {
    for i in range(0, MAX_PACKETS) {
        if mem_blocks[i].address == address and mem_blocks[i].allocated == true {
            mem_blocks[i].allocated = false;
            print("Freed block at address: " + address);
            return;
        }
    }
    print("Free failed. Address: " + address);
}

// Function: Simulate network packet creation
func create_packet(header_val: int, payload_data: string) -> Packet {
    var pkt: Packet;
    pkt.header = header_val;
    var i = 0;
    for c in payload_data {
        if i < PAYLOAD_SIZE {
            pkt.payload[i] = ascii(c); // Simplified ASCII conversion
            i = i + 1;
        } else {
            break;
        }
    }
    for j in range(i, PAYLOAD_SIZE) {
        pkt.payload[j] = 0; // Pad remaining with zeros
    }
    return pkt;
}

// Function: Simulate sending a packet over the network
func send_packet(pkt: Packet) {
    if packets_sent < MAX_PACKETS {
        network_buffer[0] = header(pkt.header) >> 24; // Mock network serialization
        network_buffer[1] = header(pkt.header) >> 16;
        network_buffer[2] = header(pkt.header) >> 8;
        network_buffer[3] = header(pkt.header);
        for k in range(0, PAYLOAD_SIZE) {
            network_buffer[HEADER_SIZE + k] = byte(pkt.payload[k]);
        }
        packets_sent = packets_sent + 1;
        print("Packet sent. Header: " + pkt.header + " Payload: " + payload_data(pkt.payload));
    } else {
        print("Network buffer full.");
    }
}

// Function: Simulate receiving a packet
func receive_packet() -> Packet {
    if packets_received < packets_sent {
        var recv_pkt: Packet;
        recv_pkt.header = int(network_buffer[0]) << 24 | int(network_buffer[1]) << 16 | int(network_buffer[2]) << 8 | int(network_buffer[3]);
        for m in range(0, PAYLOAD_SIZE) {
            recv_pkt.payload[m] = int(network_buffer[HEADER_SIZE + m]);
        }
        packets_received = packets_received + 1;
        print("Packet received. Header: " + recv_pkt.header + " Payload: " + payload_data(recv_pkt.payload));
        return recv_pkt;
    } else {
        print("No more packets to receive.");
        var empty_pkt: Packet;
        empty_pkt.header = 0;
        return empty_pkt;
    }
}

// Helper: Convert payload array to string (simplified)
func payload_data(payload: int[PAYLOAD_SIZE]) -> string {
    var s: string = "";
    for val in payload {
        if val > 0 and val < 127 {
            s = s + char(val);
        }
    }
    return s;
}

// Main execution
func main() {
    init_memory();
    
    // Simulate memory allocation
    var addr1 = malloc(50);
    var addr2 = malloc(30);
    
    // Simulate network communication
    var pkt1 = create_packet(1001, "Hello Network");
    send_packet(pkt1);
    
    var pkt2 = create_packet(1002, "Data Transfer");
    send_packet(pkt2);
    
    // Receive packets
    var recv1 = receive_packet();
    var recv2 = receive_packet();
    
    // Free memory
    free(addr1);
    free(addr2);
    
    print("Simulation complete. Sent: " + packets_sent + " Received: " + packets_received);
}

// Start the simulation
main();
