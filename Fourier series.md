# Fourier Series
:cc0:
Fourier's theorem states that any periodic function can be approximated perfectly by some weighted sum of harmonic sine and cosine waves. This sum is often infinite.
(see: [wikipedia](https://en.wikipedia.org/wiki/Fourier_series))

Arbitrary signals can be analyzed to determine the weights for the Fourier series that approximates them. This kind of analysis can be used to transform a [[Time Domain]] signal into a [[Frequency Domain]] signal. This transformation is the first step in a variety of [[Spectral Processing]] algorithms.

In calculus this is represented by the [[Fourier Transform]]. For DSP and digital audio a variety of [[Discrete Fourier Transform (DFT)]] algorithms exist. Some of these algorithms can operate in real time.

Since Fourier's theorem only holds for signals that are perfectly periodic (ie. signals that repeat exactly forever) these transform algorithms often slice an input signal into "windows". Each window is assumed to repeat forever so that the frequencies present in each window can be derived by computing the Fourier transform. This "windowing" operation is a source of error and is an example of an [[orthogonal property]]. The more you know about the signals what frequencies are present in a window (ie. a larger window size), the less you know about *when* those frequencies occurred in the time domain. 
