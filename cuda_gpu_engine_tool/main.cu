// CUDA GPU Engine Tool
// Strictly implemented using CUDA
#include <stdio.h>
#include <cuda_runtime.h>

// Kernel: Simulate high-performance parallel computation
__global__ void parallelComputeKernel(float *data, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        // Example parallel operation: square each element
        data[idx] = data[idx] * data[idx];
    }
}

// Host function to initialize data
void initData(float *data, int n) {
    for (int i = 0; i < n; i++) {
        data[i] = (float)i + 1.0f;
    }
}

int main(int argc, char **argv) {
    printf("CUDA GPU Engine Tool Initialized\n");
    
    int n = 1024 * 1024; // 1 million elements
    size_t size = n * sizeof(float);
    
    // Host pointer
    float *h_data = (float *)malloc(size);
    if (h_data == NULL) {
        printf("Host memory allocation failed\n");
        return 1;
    }
    
    // Device pointer
    float *d_data = NULL;
    cudaError_t err = cudaMalloc((void **)&d_data, size);
    if (err != cudaSuccess) {
        printf("Device memory allocation failed: %s\n", cudaGetErrorString(err));
        free(h_data);
        return 1;
    }
    
    // Initialize host data
    initData(h_data, n);
    
    // Copy data from host to device
    err = cudaMemcpy(d_data, h_data, size, cudaMemcpyHostToDevice);
    if (err != cudaSuccess) {
        printf("Host to Device copy failed: %s\n", cudaGetErrorString(err));
        cudaFree(d_data);
        free(h_data);
        return 1;
    }
    
    // Configure kernel launch parameters
    int blockSize = 256;
    int numBlocks = (n + blockSize - 1) / blockSize;
    
    printf("Launching kernel with %d blocks of %d threads\n", numBlocks, blockSize);
    
    // Launch kernel
    parallelComputeKernel<<<numBlocks, blockSize>>>(d_data, n);
    
    // Wait for GPU to finish
    err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        printf("Kernel execution failed: %s\n", cudaGetErrorString(err));
        cudaFree(d_data);
        free(h_data);
        return 1;
    }
    
    // Copy results back to host
    err = cudaMemcpy(h_data, d_data, size, cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) {
        printf("Device to Host copy failed: %s\n", cudaGetErrorString(err));
        cudaFree(d_data);
        free(h_data);
        return 1;
    }
    
    // Validate a few results
    printf("Validation - First 5 results (x^2):\n");
    for (int i = 0; i < 5; i++) {
        printf("data[%d] = %.1f\n", i, h_data[i]);
    }
    
    // Cleanup
    cudaFree(d_data);
    free(h_data);
    
    printf("CUDA GPU Engine Tool Completed Successfully\n");
    return 0;
}
