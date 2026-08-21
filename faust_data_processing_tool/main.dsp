// Faust Data Processing Tool
// Implements a data processing pipeline using Faust's functional paradigm.
// This example demonstrates a basic signal/data processing chain:
// Input -> Low-pass Filter -> Distortion -> Delay -> Output

// Import Faust standard library
import("stdfaust");

// Define processing block functions
// Low-pass filter with cutoff frequency fc and gain g
lpf(fc, g) = fi.lowpass(fc, g);

// Distortion effect
distortion(amount) = ma.clip(amount);

// Delay line
delay_time = 0.5; // seconds
my_delay = si.smooth(0.9) <: _(delay_time);

// Process data by applying filters and effects
process = 
  // Example input processing
  lpf(440, 0.5) : 
  distortion(2.0) : 
  my_delay;

// Output the processed data
process : ma.dynamics(1.0, 0.5, 0.5, 1.0);
