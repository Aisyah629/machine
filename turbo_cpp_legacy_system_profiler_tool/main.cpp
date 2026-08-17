#include <dos.h>
#include <alloc.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

#define MAX_ALLOC_TRACKED 100

typedef struct {
    void *ptr;
    unsigned int size;
    unsigned long address;
    int used;
} MemBlock;

MemBlock trackedBlocks[MAX_ALLOC_TRACKED];
int blockCount = 0;
unsigned long totalAllocated = 0;
unsigned long totalFreed = 0;

void registerAllocation(void *ptr, unsigned int size) {
    if (blockCount < MAX_ALLOC_TRACKED) {
        trackedBlocks[blockCount].ptr = ptr;
        trackedBlocks[blockCount].size = size;
        trackedBlocks[blockCount].address = (unsigned long)ptr;
        trackedBlocks[blockCount].used = 1;
        blockCount++;
        totalAllocated += size;
    }
}

void registerDeallocation(void *ptr) {
    for (int i = 0; i < blockCount; i++) {
        if (trackedBlocks[i].ptr == ptr) {
            totalFreed += trackedBlocks[i].size;
            trackedBlocks[i].used = 0;
            trackedBlocks[i].ptr = NULL;
            return;
        }
    }
}

void * __cdecl track_malloc(unsigned int size) {
    void *ptr = malloc(size);
    if (ptr) registerAllocation(ptr, size);
    return ptr;
}

void __cdecl track_free(void *ptr) {
    if (ptr) registerDeallocation(ptr);
    free(ptr);
}

void displayMemoryStats() {
    clrscr();
    cprintf("TURBO C++ LEGACY SYSTEM PROFILER\n");
    cprintf("================================\n");
    cprintf("Allocated Blocks: %d\n", blockCount);
    cprintf("Total Allocated: %lu bytes\n", totalAllocated);
    cprintf("Total Freed: %lu bytes\n", totalFreed);
    cprintf("Current Usage: %lu bytes\n", totalAllocated - totalFreed);
    cprintf("\nTracking %d active blocks\n", MAX_ALLOC_TRACKED);
}

void analyzeInterrupts() {
    union REGS regs;
    int i;
    cprintf("\nINTERRUPT VECTOR ANALYSIS (0x00-0x0F):\n");
    for (i = 0; i <= 0x0F; i++) {
        regs.x.ax = 0x3500 + i;
        int86(0x21, &regs, &regs);
        cprintf("INT %02X: Segment=%04X Offset=%04X\n", i, regs.x.bx, regs.x.dx);
    }
}

int main() {
    void *mem1, *mem2, *mem3;
    unsigned int size1 = 1024, size2 = 512, size3 = 256;
    
    mem1 = track_malloc(size1);
    mem2 = track_malloc(size2);
    mem3 = track_malloc(size3);
    
    cprintf("Memory allocated.\n");
    displayMemoryStats();
    
    free(mem2);
    cprintf("\nMemory freed.\n");
    displayMemoryStats();
    
    analyzeInterrupts();
    
    free(mem1);
    free(mem3);
    
    cprintf("\nProfiler finished.\n");
    getch();
    return 0;
}
