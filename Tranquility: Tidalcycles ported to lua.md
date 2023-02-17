# Tranquility
Tranquility is a port of Tidalcycles to lua.
- [Comparison of OSC libraries](Comparison of OSC libraries)
- [Tranquility: Thoughts on scheduling events](Tranquility: Thoughts on scheduling events)


## project log
- a bunch of past stuff

### 2023-02-09
announced Tranquility on the tidalcycles forum and asked for help with my cooperative multitasking question...


### 2023-02-10

I'm pretty sure its my implementation of Pattern that is the problem and not the `LinkClock`. I made the thread sleep super long and it actually waited to send the osc message... I think when `onsetsOnly` is called it thinks that every moment inside of `Pure("gabba")` has an onset...

### 2023-02-16

I wrote unit tests to isolate the problem with the pattern implementation. For a while it looked like I had exposed the problem. The test revealed events coming back after `onsetOnly` filtering even though part and whole would have different onsets... this would cause the pattern to behave like a continuous signal and cause the chainsaw kicks I was hearing in superdirt

However, I had been careless in the way I wrote the test. After I fixed my mistake it passed. I'm back to the drawing board on the problem. I am now convinced it must be a problem in the scheduler.

Here is what I know... the thread is sleeping as expected... the pattern created by `Pure` behaves as expected and has only one onset at the beginning of the cycle.

This leads me to believe that it is being queried incorrectly... for example, the scheduler may be repeatedly asking for the beginning of the cycle and thus is repeatedly returning the onset...

AHA! found it... it's because I didn't make the convenience constructor for fraction that converts decimal numbers to the closest fractional representation... the `LinkClock` queries the `notifyTick` method with decimal numbers... these are interpreted as the nearest whole cycle...
