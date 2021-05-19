# MinBlep (Minimum Band-Limited Step)

MinBlep is an algorithm for generating bandlimited classic analog waveforms with a computer. It allows for flexibility in modulating the shape of the waveform that is typically available on analog equipment. (eg. hard sync) This algorithm was first outlined in the paper *Hard sync without aliasing* by Eli Brandt. (paper available [here](https://www.cs.cmu.edu/~eli/papers/icmc01-hardsync.pdf))

Hard-sync is where one oscillator resets the phase of another. The frequency of one of the oscillators is typically swept to produce a modulation of the harmonic spectra.

Resetting the phase exactly on a computer introduces discontinuities that are not band-limited. 

# the algorithm
Emulating hard-sync using [[BLIT]] typically requires the generation of a band-limited synchronization signal where resets must be calculated to fall on sample boundaries. Tables are generated storing these various impulses and are referenced and integrated. In BLEP the integration is done first