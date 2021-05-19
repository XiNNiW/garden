---
---
# FM Synthesis
Frequency Modulation synthesis is a technique pioneered by John Chowning. It is a synthesis technique where complex timbres are created from simple tones by rapidly changing the frequency of the tone. If the pitch is modulated at a rate where humans have pitch perception, audible side-bands are generated. The main tone is called the carrier wave and the tone that determines how fast to change the pitch is called the modulator wave. 

Many arrangements of modulators and carriers have been explored. Each arrangement has its own timbrel possibilities.

Here is the typical equation for FM synthesis:
$$y(t)=sin(w_{c}t+Bsin(w_{m}t))$$
Where $w_{c}$ is the carrier wave frequency, $w_{m}$ is the modulator frequency, and $B$ is the modulation index.

The index controls how deeply the modulator affects the pitch and therefore also controls how harmonically rich the output is.

The modulation frequency is typically set to some ratio of the carrier frequency. A simple relationship between these two typically creates a more harmonic spectra. Weirder results can be had by detuning this relationship. 

### Band-limiting
Although it is possible to predict the spectra of a FM oscillator precisely (see Stanford's [intro to FM](https://ccrma.stanford.edu/software/snd/snd/fm.html)), it is not generally feasible to strictly [band-limit](Bandlimited Oscillator.md) its output due to the theoretically infinite number of side-bands. However, for many FM architectures, the following rule of thumb can be used to limit the value of the modulation index $B$ in order to make sure that aliasing will be minimal. In this way, it can be [[Quasi-Bandlimited]]. The rule of thumb is as follows:
$$BW = 2f_{m}(B+1)$$
Where $BW$ is bandwidth, $B$ is the modulation index, and $f_{m}$ is the modulation frequency. For a given pitch, you can solve for the maximum allowable bandwidth and then work backward to a maximum modulation index to limit to for that note. 
$$BW_{max} + f_{c} = \frac{f_{sr}} {2}$$
$$B_{max} = \frac {BW_{max}} {2f_{m}} - 1$$
$$B_{max} = \frac{f_{sr}} {4f_{m}}$$
In practice I've found that if that doesn't work, you can just divide by a number larger than 4. This safety from aliasing will come at the cost reducing the brightness of the sound and may not be appropriate for all use cases. (eg. synthetic percussion)

### FM operators
There are many ways to organize FM oscillators in relationship with one another. Since Yamaha commercialized the algorithm in the 1980's, it has been most common to organize them in terms of FM operators. An FM operator is simply a waveform (often $sin$) multiplied by some envelope. (typically ADSR)
$$op(t,modulators) = env(t)wave(wt+Bmodulators(t))$$
These operators are then set to modulate each other in various ways.
For example, the following is a common arrangement that might be found on a Yamaha synth:
$$op_{A}(t, op_{B}(t) + op_{B}(t) + op_{C}(t) + op_{D}(t))$$
The envelopes allow different spectra to be animated over time. This can be used in an attempt to model instruments like horns or simple explored on its own terms.

This arrangement is very flexible but creates a lot of parameters to control. 

### Feedback FM
Even wilder timbres can be made by allowing an operator to modulate itself. The basic idea is the same as regular fm except that the modulator signal is the carrier signal delayed by 1 sample. Chaos is easily achieved leading to noisy textures that make for good percussion. At low feedback settings the system usually doesn't devolve directly into noise but rather is made harsher and more aggressive by the feedback.
