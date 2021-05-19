# DSF (Discrete Summation Formula)

A DSF is an approximation of an ideal waveform (such as SAW or SQUARE) that uses trig identities to approximate the wave up to a given number of harmonics.

All periodic sound can be represented a [[Fourier series]] of individual sine and cosine waves. This infinite series can be truncated to produce a wave with a given number of harmonics. (see: [[Bandlimited Oscillator]]) This truncated sum may have a "closed form" solution when trig identities can be used to reduce the sum to a single term. This makes it more efficient to implement than [[Additive Synthesis]].                               

Like the basic [[BLIT]] algorithm, DSF has limitations when it comes to smoothly changing/glissing frequencies the number of harmonics in a DSF formula is an integer value. When trying to render a [[glissando]] with a DSF the harmonics entering and leaving the sound can be heard as abrupt steps.

# example
The following is a summary of an example presented in *Computer Music* by Dodge and Jerse: 

A bandlimted pulse wave with `N` harmonics can be constructed with the formula:

$$ y(t) = \frac {A} {N} \sum_{k=1}^N cos(2 \pi kf_ot) $$

This sum can be reduced to the following "closed form" DSF:

$$ y(t) = \frac {A} {2N} [\frac {sin((2N+1) \pi f_ot)} {sin(\pi f_o t)} -1]$$

An implementation using the bottom form will need to account for the case where the denominator goes to zero. For this case the formula above can be re-written with cosines:

$$ y(t) = \frac {A} {2N} [\frac {(2N+1) cos((2N+1) \pi f_ot)} {cos(\pi f_o t)} - 1]$$