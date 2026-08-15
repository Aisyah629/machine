// main.ck
// Real-time audio synthesis and sound processing framework

// A simple sine wave oscillator
SineWave s;
// A gain control
Gain g;
// Output to the sound card
s => g => dac;

// Set the frequency of the sine wave
1000 => s.freq;
// Set the gain
0.5 => g.gain;

// Run the patch for a bit
1::second => now;

// Change frequency
2000 => s.freq;
1::second => now;

// Stop the patch
0 => g.gain;
100::ms => now;
