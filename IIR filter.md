# IIR Filter
An Infinite Impulse Response filter is a digital filter implemented by a difference equation that included references, not only to past inputs, but also to pas output values. A general form for the equation would be as follows:

$$ y[n] = \sum_{i=0}^p a_{i}x[n-i] + \sum_{j=0}^q b_{j}y[n-j] $$

IIR filters are not guaranteed to be stable or to preserve phase relationships. However, it is possible to achieve steep cutoff responses with very few terms.
