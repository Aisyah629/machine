__kernel void new_opencl_kernel(__global const int *input, __global int *output, const int size) {
    int gid = get_global_id(0);
    if (gid < size) {
        output[gid] = input[gid] * 2;
    }
}
