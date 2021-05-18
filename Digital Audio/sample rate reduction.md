# Sample Rate Reduction
Sample rate reduction is an audio effect where the audio signal is deliberately under-sampled so as to produce in-harmonic [[aliasing]] distortion and limit the maximum frequency. 

It is sometimes implemented as a kind of sample and hold operation on a digital signal. Imagine an audio processing block with 2 inputs. The first is the signal and the second is the trigger. A trigger signal will either cause the block to pass the first signal along or continue outputting the signal value from the last time the trigger signal was high. If the trigger signal repeats at some frequency lower than the sampling rate, the result will be that the audio is resampled at that frequency. If the source audio contains frequency components higher than 1/2 the trigger signal's frequency then those components will alias and show up in the output as in-harmonic side-bands. 

It also has the effect of lowpass filtering the signal as frequencies higher than 1/2 the trigger signal's frequency cannot be represented in the resampled output. 

TODO: implement this in algae and show the implementation here.