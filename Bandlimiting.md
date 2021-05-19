# Bandlimiting
Bandlimiting is when a digital audio algorithm is prevented from producing frequencies outside the 1/2 sample rate nyquist limit. This prevents [[aliasing]]. 

A synthesis algorithm can be prevented by design from producing harmonics that exceed this limit. (see: [[Bandlimited Oscillator]])

An algorithm that can not be bandlimited by design may still be bandlimited by [[oversampling]] and filtering. When oversampled, the out of bounds harmonics can still be filtered out before the sample rate is converted back to the main sample rate. This prevents the aliased frequencies from being sampled at all.

A synthesis algorithm may be [[Quasi-Bandlimited]] if some other technique or heuristic is used to prevent out of bounds harmonics from being too loud or too noticeable but does not prevent them all together. 