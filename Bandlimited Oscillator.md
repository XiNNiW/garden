# Bandlimited Oscillator
Within digital audio, a band limited oscillator is any oscillator algorithm that refrains from producing harmonics above the 1/2 sample rate limit. It produces no [[aliasing]] artifacts. (see: [[Bandlimiting]])

Consider the Fourier expansion a perfect sawtooth wave:

$$y(t) = \frac {1} {2} - \sum_{n=0}^\infty \frac {1} {n\pi} sin(2\pi nt)$$

It requires an infinite number of harmonics to create. Even for low frequency waves, some of those harmonics will alias. As the fundamental frequency increases the [[aliasing]] distortion will get worse as more and more harmonics fold over.

This kind of [[aliasing]] can occur for most complex waveforms, even those that can be represented with a finite number of harmonics. At some point on the keyboard they may begin to alias and distort.

The effect is typically not very pleasing for an oscillator. (it sounds like crap)

In order to create musically useful complex waves care has to be taken to ensure that no harmonic content will alias.

Here are some algorithms for generating bandlimited waves:
1. [[BLIT]]
2. [[BLEP]]
3. [[minBLEP]]
4. [[PolyBLEP]]
5. [[DSF]]
6. [[Additive Synthesis]]

Sometimes it is not possible or not feasible to band-limit an oscillator algorithm. (eq. [[FM Synthesis]]) In those circumstances [Quasi-Bandlimited](Quasi-Bandlimited Oscillator.md) techniques are useful. 

Other times bandlimiting is not necessary as the generated sound is noisy and chaotic enough that the aliased harmonics blend in with the noise. (eg. [[White Noise]])