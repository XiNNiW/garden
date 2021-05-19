---
---
# Digital Filter
A digital filter is a process that takes some input signal and produces some (possibly modified) output signal. In that way almost everything that interacts with an audio signal inside the computer is a digital filter. 

Filters can be used to subtract or add frequency components of input signals, as well as manipulate the phase of those frequency components. 

## common types of filters

Common types of filters are names based on their effect on incoming frequencies.

### lowpass
It lets through the low frequencies and attenuates the high frequencies.

### highpass
It lets through the high frequencies and attenuates the low frequencies.

### bandpass
Both high and low frequencies are attenuated and some set of middle frequencies are allowed to pass.

### notch
Both high and low frequencies are allowed to pass and some middle band of frequencies is attenuated.

### allpass
No frequencies are attenuated but the phase relationships are changed.

### comb
The signal is combined with a delayed version of itself to create phase cancellation. This mimics the effect created when a sound bounces off of a surface. 

## filter design

Most filters can be thought of as dynamical systems and discrete versions mathematical techniques for analyzing differential equations can be applied to analyze the behavior of the filter system to input. Typically, it is interesting to know the following about a filter: 
1. How the system will respond to a unit impulse
2. Under what conditions its output is stable, semi-stable, and unstable
3. How incoming frequencies will be affected (ie. its frequency response)
4. How the phase of incoming signals will be affected
5. How to calculate parameters or coefficients for the filter from more intuitive quantities (such as cutoff frequency and resonance)

Answering the above typically involves designing a filter in state space and deriving its difference equation by taking the inverse Z transform. For Linear Time Invariant filters this operation is easy as $Z_{-1}(\sum_{i=0}^p a_{i}Y_{n-i}) = \sum_{i=0}^p a_{i}y[n-i]$ If the filter is not a Linear Time Invariant Filter the power series must be solved or referenced from a lookup table.

## digital filter implementation

1. Convolution with an recorded impulse response
2. A difference equation with a Finite Impulse Response ([[FIR filter]])
2. A difference equation with a Infinite Impulse Response ([[IIR filter]])
2. A difference equation with lookahead ([[non-causal filter]])
