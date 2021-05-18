# Digital Sampling
Sound (and analogous signals) are represented inside the computer in the form of samples. A sample is a snapshot of the signal's amplitude value at a given point in time. These samples are collected at regular intervals. The speed at which the samples are collected is called the sample rate.

A signal is represented as a long stream of these sample values. (for example: `[0 0.2 0.22 -0.1 -0.02 -0.5 -1 -0.66 ...]` could be a signal inside the computer.)

The stream of sample values is converted to real sound (ie. pressure waves in the air) by a Digital Audio Converter ([DAC](DAC)) coupled with an amplifier and speaker. The DAC takes the sampled values and creates a smooth, continuous analog voltage by interpolating between the sample values using sinusoidal waves. This voltage is then typically amplified and fed to a speaker.

The sample rate affects what kinds of sounds can be accurately recorded and reproduced. Nyquist's sampling theorem states that the highest frequency that can be accurately represented by a sampled recording is 1/2 the sampling rate. In modern computers, 44.1 kHz, 48 kHz, and 96 kHz are the most common sampling rates. If sample values fluctuate at more than 1/2 the sample rate, the tone will [alias](aliasing.md), resulting in in-harmonic distortion of the signal. 

