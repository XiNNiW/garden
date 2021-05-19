
---
---
# Numerically Controlled Oscillator
A numerically controlled oscillator is a simple algorithm for computing the changing phase of an oscillator over time. It can be used to make all kinds of waveforms and is often at the heart of more complicated synthesis algorithms. (see: [[FM Synthesis]])

So how does it work? To make an NCO we keep some state for tracking the phase of the oscillator. We then convert the desired frequency into a phase increment. The phase increment is the amount that we add to the phase every sample. 

The formula for the phase increment:
$$ inc = 2\pi\frac{f}{f_{sr}} $$
(where $f$ is the frequency and $f_{sr}$  is the sample rate)

For each sample we compute the output value using the phase and then increment the phase. The following psuedo-code would make a sine wave oscillator:

```
struct SinOsc{
	float phase;
	void update_phase(float freq, float samplerate){
		float inc = 2*PI*freq/samplerate;
		phase+= inc;
		if(phase>2*PI) phase -= 2*PI;
		return next_phase;
	}
	float process(float freq, float samplerate){
		float next_sample = sin(phase);
		update_phase(freq, samplerate);
		return next_sample;
	}
}


```

In reality, computing the value of the increment every sample may be unnecessary and a separate `setFrequency` method could be made to make the process more efficient.

But isn't a sine wave just a pure math function? Why do we have to keep track of the phase state? Couldn't we just write something like the following?
```
	float inc = 2*PI*freq/samplerate;
	float sample = sin(sample_number*inc);
```
The above would be purely functional and most of the time at the top of our code we are iterating through sample indexes as we fill a buffer of output samples. The problem is with truncation error. As we multiply large floating point numbers, we lose information as we only have a limited number of bits to represent any floating point number. The result is an oscillator that rapidly goes out of tune and distorts. (fixed point numbers also have problems)

We could make our oscillator design more referentially transparent however.

```
float update_phase(float phase, float increment, float period = TWO_PI){
	float next_phase = phase+increment;
	if(next_phase>period) next_phase -= period;
	return next_phase;
}

struct sin_osc_t {
	float phase;
	float increment;
	float output;
}

sin_osc_t process(sint_osc_t state){
	sin_osc_t next_state = state;
	next_state.output = sin(state.phase);
	next_state.phase = update_phase(state.phase, state.increment);
	
	return next_state;
}


```

In the algorithm above we avoid mutating any state values. Its purely functional. We can do all of our mutation in one layer of the code and treat the rest as pure functions. This has benefits for testing, multi-threading, and organizing complex algorithms. It, however, may be less efficient as we will copy more data. (each function call returns a copy of its input data and leaves the original intact)

I'm curious of the limits of the above technique in a language like `C++` where code is not lazily evaluated and most data types are not specialized for pure functional use. (eg. Haskell Lists) This could potentially limit the performance in a way that is unacceptable for many applications. However, most modern compilers make aggressive optimizations and many data copy operations could be eliminated by inlining the code. 

#TODO

Compile both algorithms and compare the generated assembly to see what optimizations were made. Then compare the performance.

