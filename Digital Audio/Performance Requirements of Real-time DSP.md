---
---
# Performance Requirements of Real-time DSP
In order to convincingly generate/manipulate audio in real time without audible clicks or pops, the audio code must be capable of delivering rendered samples to the output at a speed that is faster than the sample rate. If the algorithm is unable to complete rendering a section of audio before playback, nasty clicks and glitches will occur. 

## Things NOT to do on the audio thread
1. **DON'T** allocate memory
2. **DON'T** do any kind of IO
3. **DON'T** lock the thread or interact with locks on other threads
4. **DON'T** throw or handle exceptions, don't use code that is capable of throwing exceptions. (even having exceptions in your code path adds branching)

The above operations have one thing in common: they take an indeterminate amount of time to resolve, if they resolve at all, or they are just plain slow (eg. exceptions). Locking or interacting with other threads that can lock can be disastrous and cause enormous performance penalties or worse deadlock. The OS typically does not give the thread your audio code is running on very high priority.

## Things to avoid if possible
1. Branching: If and switch statements are expensive. The compiler is clever however, and may optimize the conditional to a branchless conditional during compilation. All the same, it is best to avoid the conditional or move it to outside the render loop if it is not absolutely required.
2. Trig: The built in trig functions are not performant. Also, the built in math library typically leaves it to the user to implement some trig operators in terms of the few operators they do define using trig identities. This result in even slower operators. If possible, these functions should be re-implemented using interpolated look-up tables or cheaper approximations. Generation of look-up tables should happen statically or at compile time. 
3. Division: It's slower than multiplication.

## Things to do
1. [[SIMD vectorization]]: If possible, vectorizing code will make it go much much faster.
2. Pre-compute as much as possible and store the state for later. (ex. Your [[numerically controlled oscillator]] algorithm doesn't need to know the frequency when its running, it needs to know the phase increment. If you compute the phase increment and store it ahead of time you can avoid writing `TWO_PI*freq/sampleRate` in your rendering code.)
