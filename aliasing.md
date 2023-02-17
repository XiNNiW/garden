# Aliasing
Aliasing is where a digital signal (or some component of a signal) fluctuates at a frequency higher than 1/2 the sampling rate. For example, assuming a sampling rate of 48 kHz, any tone or harmonic higher than 22 kHz will alias. The energy of the aliased tone will then be reflected downward in pitch into potentially audible side-bands. The result is typically the introduction of high-pitched in-harmonic tones to the signal. Sometimes this effect is [desirable](sample rate reduction). Most often it is not desirable. 

Consider the following signal: `[0 1 0 -1 0]` Upon output, the [DAC](DAC) will interpolate between these points using a sinusoidal wave. The result will be a tone at 1/4 the sample rate as its period is 4 samples long. 

Imagine that we tried to generate a signal that was 3/4 the sample rate. The values that we would sample would be as follows: `[0 1 0 -1 0]`

Its the same signal and would result in a tone 1/4 of the sample rate. Any signal component that fluctuates faster than 1/2 the sample rate will result in a copy or alias of that component of a lower pitch.

What would happen if we tried to generate a signal at the sample rate? If the wave started at precisely the same moment as the first sample we would end up with the following signal: `[0 0 0 0]`. Every time we record the value, the wave is at the same position as it started. 
If it were perfectly out of phase with the first sample: `[1 -1 1 -1]`. 

This effect has analogues in video and other sampled mediums. Our example above is the audio equivalent of a wheel rotating at the frame rate of the camera. It appears in the footage to be completely still. 
