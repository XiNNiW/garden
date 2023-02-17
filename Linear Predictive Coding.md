# Linear Predictive Coding (LPC)

Linear predictive coding is a set of analysis and re-synthesis techniques. It is often used for data compression of speech but also has application for cross-synthesis, pitch corrections, and other more experimental techniques. It works by modeling a source signal as a set of all-pole bandpass filters excited by either a noise source or a pulse-wave. The coefficients of these filters are estimated using linear regression and animated over time to create the illusion of speech. As a data compression technique it can achieve up to a 17:1 reduction in data for a speech signal.

It excels at modelling speech but can also be highly successful in modelling other monophonic sounds that include pitched and unpitched moments.

When modelling speech, the noise source is used to excite the filters during consonants and the pulse wave is used to excite the filters during vowels.

## How it works

A given input signal $x(n)$ is modelled as a bank of bandpass filters ($h(n)$) excited by a source signal ($e(n)$).

$$
x(n) = h(n)*e(n)
$$
If the timestep being modelled is a pitched sound $e(n)$ will be modelled as a pulse train. If the timestep is unpitched $e(n)$ will be white noise. In either case, $e(n)$ is spectrally flat and all harmonic information is modelled in the filter $h(n)$.
$$
X(z) = H(z)E(z)$
     = \frac{1}{1 - \sum{k=1}^p a_{k}z^-k}E(z)
 = \sum{k=0}^p a_{k}z^-k X(z) + E(z)
...z transform...
 x(n) = \sum{k=1}^p a_{k}x(n-k) + e(n)
$$

In order to create the model above we need values for our filter and we need to know if we should use noise or a pitched sound for our source. If we want a pitched sound we also need to know what pitch we should use.

### Estimating filter coefficients

If we can find the coeficcients $$a_{k}, k=1...p$$ for a given timestep, we can model the signal for that timestep.

Note: in order to do this our signal needs to be longer than the $$p$$ timesteps neccesary for our filter memory.

Given $N$ samples we can write $N$ equations and solve them.
$$
a = \begin{bmatrix} a_{1} \\ ... \\ a_{p} \end{bmatrix}
x_{i} = [x(n-1+i)...x(n-p+i)]

 x(n) = x_{0} \cdot a + e(n)
 x(n+1) = x_{1} \cdot a + e(n)
...
 x(n+N) = x_{N} \cdot a + e(n+N)
$$

Each equation contains our $p$ coefficients based on the samples from our signal $x(n)$. This system is overdetermined as there are more equations than variables to solve. Therefor, we approximate a solution using the method of least squares.

We can rewrite our equations as:
$$
e = b - A \cdot a
  = b - \hat{b}
$$
where:
$$
b = \begin{bmatrix} \\ x(n) \\ ... \\ x(n-N) \end{bmatrix}
e = \begin{bmatrix} e(n) \\ ... \\ e(n-N) \eng{bmatrix}
A = \begin{bmatrix} x_{0} \\ ... \\ x_{N} \end{bmatrix}
$$

Notice that $b$ is our original signal $x$, $\hat{b}$ is our estimated signal, and our noise/pulse input $e(n)$ is now the error of our estimation.

In the method of least squares, we try to minimize that value of $||e(n)||^2$. As the system is overdetermined, there is no exact solution. Another way of saying this is that our signal vector $b$ is not in the column space defined by $A \cdod a$. When we say minimize $||e(n)||^2$ we want to find the line that IS in our column space that is as close as possible to $b$. The vector in our column space that is closest is defined as the projection of $b$ onto $A \cdot a$. (Kahn academy video for solving this system: https://www.youtube.com/watch?v=MC7l96tW8V8)

$$
a = (A^T A)^-1 A^T b
$$
With this we have found the resonances.

### Estimating the residual, e(n)

We need to know the following:
- the power of the signal x(n)
- the pitch of x(n) ... this will require pitch detection


### Analysis
We break the signal up into windows $N$ samples long, apply and overlap add window function, and use the process above to solve the values of $a$ and $e$.

something something Yule-Walker equations and FFT for faster implementation... they provide a way to get $a$ and the power/variance from the auto-correlation of the signal...
$$
R \vec{a} = -\vec{r}
a = -R^-1 \vec{r}
$$

### Re-synthesis
