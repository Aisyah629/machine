// ============================================================================
// HLSL Data Processing Utility Tool
// File: main.hlsl
// Description: A generic compute shader for parallel data processing.
//              This shader demonstrates a common pattern for filtering,
//              transforming, and reducing data arrays on the GPU.
// ============================================================================

// ============================================================================
// Struct Definitions
// ============================================================================

// Input data structure. Adjust fields based on specific processing needs.
struct InputData {
    float4 values; // 4 components per thread for parallelism efficiency
    uint metadata; // Example metadata field
};

// Output data structure. Can be sparse or dense depending on the operation.
struct OutputData {
    float4 result;
    float confidence; // Example additional output
};

// ============================================================================
// Globals / Buffers
// ============================================================================

// Input buffer containing the raw data to process.
// The size should be a multiple of the thread group size for optimal performance.
RWStructuredBuffer<InputData> g_InputBuffer : register(t0);

// Output buffer where processed data will be written.
// Use RWStructuredBuffer or AppendStructuredBuffer if output size varies.
RWStructuredBuffer<OutputData> g_OutputBuffer : register(u0);

// Global index to handle dynamic output sizes if using AppendBuffer
// Alternatively, use structured buffer with pre-allocated size.
RWStructuredBuffer<uint> g_OutputIndices : register(u1); // For indexing if needed

// ============================================================================
// Constants
// ============================================================================

// Thread group size (must match [numthreads] invocation)
#define GROUP_SIZE 256

// ============================================================================
// Shader Functions
// ============================================================================

// Custom processing function. Replace with your specific logic.
// Example: Filter data based on a threshold and apply a transformation.
OutputData ProcessData(InputData input) {
    OutputData output;
    
    // Example: Pass if first component > threshold
    if (input.values.x < 0.5f) {
        // Invalid data marker
        output.result = float4(0.0f, 0.0f, 0.0f, 0.0f);
        output.confidence = 0.0f;
        return output;
    }
    
    // Example: Transform values (e.g., normalize, scale, or custom math)
    output.result = input.values * 2.0f; 
    output.confidence = input.values.x; // Example confidence metric
    
    return output;
}

// Main compute shader entry point
[numthreads(GROUP_SIZE, 1, 1)]
void main(uint3 threadID : SV_DispatchThreadID) {
    uint index = threadID.x;
    
    // Bounds check to prevent out-of-bounds access
    if (index < g_InputBuffer.Length()) {
        InputData inputData = g_InputBuffer[index];
        
        // Process the data
        OutputData outputData = ProcessData(inputData);
        
        // Write result to output buffer
        // If using a fixed-size output buffer, map directly or use a counter
        // For variable output size, use InterlockedAdd on a counter and a separate AppendBuffer
        // Here we assume a pre-allocated output buffer of same size for simplicity
        g_OutputBuffer[index] = outputData;
    }
}

// Optional: Helper function for atomic operations if needed
// Example: Increment a global counter for unique output indexing
void IncrementOutputCounter() {
    uint newIndex;
    InterlockedAdd(g_OutputIndices[0], 1, newIndex);
    // Use newIndex for writing to an AppendStructuredBuffer if needed
}
