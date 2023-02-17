:cc0:
# BLIT (Band-Limited Impulse Train)

BLIT is an algorithm for creating band-limited waveforms first outlined in the paper *Alias-Free Digital Synthesis of Classic Analog Waveforms* by Julius Smith and Tim Stilson. (paper available [here](https://ccrma.stanford.edu/~stilti/papers/blit.pdf)) It can be used to generate a wide variety of waves but excels at reproducing the forms that are typically found on analog synthesizers. (eg. Saw, Square, and Triangle) The algorithm focuses on first creating a band-limited pulse wave. An ideal pulse wave contains frequency energy is all bands, and therefor can be filtered down to produce all other waveforms. 

## the algorithm
An approximate pulse is designed by using a sinc function whose harmonic content does not exceed 1/2 of the Nyquist frequency. This means that all filtered waves will also be band-limited. 

These Impulses are sometimes stored in a table of BLITs to optimize performance.

A filter is then designed that will transform the pulse into another wave. Often this filter carries out one or several integration operations. For example, with one pass of an integrator the pulse becomes a saw wave. 



## limitations
The initial pulse wave is dependent on the fundamental frequency of the desired note and is only capable or generating some integer number of harmonics above this fundamental. The algorithm typically sets this integer number of harmonics to the maximum number that would not alias. As the pitch rises, harmonics are removed one by one as they pass the 1/2 Nyquist threshold. This step-wise removal of frequency can cause audible zipper noise on a glissando. For sounds that can smoothly gliss in pitch other algorithms are required. 

Other modulations of the sound are not smoothly handled by that BLIT algorithm along. For example, hard-sync, commonly found on analog equipment, introduces modulation of the underlying pulse that would not be possible with BLIT alone. (see [minBLEP](minBLEP))
