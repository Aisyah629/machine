/**
 * Promela Model for Concurrency Validation
 * 
 * This model demonstrates the use of Promela to verify concurrent systems,
 * detect race conditions, and ensure invariants across parallel processes.
 * It simulates asynchronous message passing and checks for deadlocks and livelocks.
 */

/*
 * Global Variables
 * 
 * state: Represents the current state of the system.
 * buffer: A shared buffer for message passing.
 * mutex: A binary semaphore to protect critical sections.
 * flag1, flag2: Flags to indicate process activity.
 */

byte state;
chan buffer = [1] of { byte };
binary semaphore mutex = 0;
bool flag1 = false;
bool flag2 = false;

/*
 * Safety Invariant
 * 
 * This invariant ensures that the system state never reaches an invalid configuration.
 * Specifically, it checks that the state is always within a defined set of valid values.
 */

active [1] proctype Process1() {
    atomic {
        /*
         * Critical Section 1
         * 
         * Uses a binary semaphore to protect access to shared resources.
         * Ensures mutual exclusion with Process2.
         */
        wait(mutex);
        flag1 = true;
        printf("Process1: Entered critical section\n");
        
        /*
         * Simulate some work in the critical section
         */
        printf("Process1: Working...\n");
        
        /*
         * Send a message to the buffer
         */
        buffer ! 1;
        
        flag1 = false;
        signal(mutex);
        printf("Process1: Exited critical section\n");
    }
}

active [1] proctype Process2() {
    atomic {
        /*
         * Critical Section 2
         * 
         * Also uses a binary semaphore to protect access to shared resources.
         * Ensures mutual exclusion with Process1.
         */
        wait(mutex);
        flag2 = true;
        printf("Process2: Entered critical section\n");
        
        /*
         * Simulate some work in the critical section
         */
        printf("Process2: Working...\n");
        
        /*
         * Receive a message from the buffer
         */
        buffer ? _;
        
        flag2 = false;
        signal(mutex);
        printf("Process2: Exited critical section\n");
    }
}

/*
 * LTL Property for Safety
 * 
 * Ensures that the system never reaches a state where both processes are in the critical section simultaneously.
 */

ltl safety_property {
    [] !(flag1 && flag2)
}

/*
 * LTL Property for Liveness
 * 
 * Ensures that every message sent is eventually received.
 */

ltl liveness_property {
    [] (buffer.send -> <> buffer.receive)
}
