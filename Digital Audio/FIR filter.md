
---
---
# FIR filter
A Finite Impulse Response (FIR) filter is a kind of digital filter that is implemented by a difference equation that references only past values of the input. A general form for a FIR filter is as follows:
$$ y[n] = \sum_{i=0}^p a_{i}x[n-i] $$

The values of the coefficients and the number of terms will determine the character of the filter. 

FIR filters are always stable and they will not distort the phase relationships of the signal. However, to achieve steep cutoffs, many terms are required or many FIR filters must be put in series. 