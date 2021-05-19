
---
---
# Single Instruction Multiple Data
SIMD or "Single Instruction Multiple Data" is an optimization technique that takes advantage of extensions to the instruction set offered by some processors. These extended instructions allow for multiple numbers to be affected by an operation during a single cycle of the processor. 

This has been important tool in the optimization of real time algorithms for graphics and audio, among other applications. 

#TODO: document the things I learn about SIMD here

## techniques for utilizing SIMD

### use intrinsics
There are libraries available for manually instructing the compiler to load, shuffle, and unload data from registers. This lets you force the compiler to utilize SIMD for particular operations.

### auto-vectorization
Provided that the compiler is set to optimize for speed (eq. the flag `-O3` is set for `gcc`) the compiler will recognize certain patterns and may introduce SIMD vectorization as it compiles. This typically occurs when compiling for loops. The compiler is sensitive to the pattern present in the code and even slight deviations may prevent vectorization.  

I have found it useful to explore sub sections of my code using tools like [Compiler Explorer](https://godbolt.org/) to look at the resulting assembly and see what the compiler did. For `c++` and `c` the `gcc` project has a [page](https://gcc.gnu.org/projects/tree-ssa/vectorization.html#unvectoriz) on what the compiler is able to vectorize. 

Here are some of the components of patterns I am aware of so far:

#### 1. Looping over a statically sized container
This doesn't necessarily result in vectorization on its own but can result in [[loop unrolling]] depending on the size of the container. Loop unrolling is significantly faster then having control structure in the assembly. 
#### 2. Binary or unary operations with constant values in a loop
If every element of a container operated on by a binary or unary op and the other operand is constant with respect to the loop, the compiler will likely be able to use SIMD to act on multiple array elements at the same time. 
#### 3.  Binary or unary operations with other vectors in a loop
If every element of a container is operated on by some equation and the other operands are also vectors of the same size that are iterated over, the compiler is often able to leverage SIMD to act on multiple elements of the vectors together with SIMD.
#### 4. No mutating operands in the loop
If the loop mutates the state that it depends on for an equation or some set of operations it is unable to be vectorized as each iteration of the loop depends on the last loop's end state. For some DSP applications (ex. [[IIR filter]]s), this feel unavoidable. 

## Opportunities to vectorize DSP code
### operation on blocks of samples
If you're algorithm is capable of operating on vectors or blocks of samples, the compiler may be able to vectorize operation over the block of samples using SIMD. (ex. multiplying 2 blocks together, multiplying a block by a constant, ect...)
### operations over multiple voices
If the algorithm has multiple parallel components with the same structure, (ex. a synth voice with a unison section, an oscillator bank, a bank of parallel filters) the compiler may be able to use SIMD to complete the iterations of the loop in parallel as each iteration is completely independent of the others. 


