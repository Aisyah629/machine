# Real-Time Audio Synthesis Tool

## Overview
This tool is designed for real-time audio synthesis using the Squeak programming language. It leverages Squeak's sound primitives to generate, manipulate, and play audio signals in real-time.

## Features
- Real-time audio generation
- Waveform synthesis (Sine, Square, Sawtooth, Triangle)
- Frequency and amplitude modulation
- Real-time playback

## Usage
1. Open the Squeak environment.
2. Load the `main.squeak` file.
3. Run the `AudioSynthesisTool new open` command to start the tool.
4. Use the provided interface to generate and manipulate audio.

## Code Structure
- `AudioSynthesisTool`: Main class for managing audio synthesis.
- `Waveform`: Base class for waveform generators.
- `SineWave`, `SquareWave`, `SawtoothWave`, `TriangleWave`: Specific waveform implementations.

## Dependencies
- Squeak Smalltalk environment

## License
MIT License
