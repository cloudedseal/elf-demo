#include <stdio.h>
#include <stdlib.h>

// Global variable (initialized) → .data
int global_data = 42;

// Global variable (uninitialized) → .bss
int global_bss;

// Constant string → .rodata
const char *message = "Hello from .rodata!";

// Static local variable → stored in .data (not .bss, since it's initialized)
void counter() {
    static int count = 0;
    count++;
    printf("Counter: %d\n", count);
}

// Destructor function → .fini_array
__attribute__((destructor)) void finalize() {
    printf("Finalizing...\n");
}

// Constructor function → .init_array
__attribute__((constructor)) void initialize() {
    printf("Initializing...\n");
}

// Function in .text
void print_message() {
    printf("%s\n", message); // Uses PLT/GOT for printf
}

int main() {
    // Local static variable → stored in .data (initialized)
    static int local_static = 100;
    
    printf("Global Data: %d\n", global_data);
    printf("Global BSS: %d\n", global_bss);
    printf("Local Static: %d\n", local_static);
    
    print_message();
    
    for (int i = 0; i < 3; i++) {
        counter(); // Modifies static variable in .data
    }

    return 0;
}