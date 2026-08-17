/**
 * XMOS Architecture Tool Implementation
 * Language: XMOS (xC)
 */

import xdm;
import xscope;
import clock;
import timer;

clock clk;
timer tmr;

[[combinable]]
void task() {
    clk : clock;
    tmr : timer;
    int val;

    // Configure and start clock and timer
    clk :> val;
    tmr when timera :> val;

    xscope_io_start();
    printstr("XMOS Architecture Tool Initialized\n");
    xscope_io_end();

    while (1) {
        // Simulate parallel processing typical of XMOS
        clk :> val;
        tmr when timera :> val;
        printint(val);
        printstr("\n");
    }
}
