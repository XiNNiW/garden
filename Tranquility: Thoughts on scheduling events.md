# thought on scheduling events

One of the main responsibilities of the tranquility application is to periodically query the user specified patterns and convert the resulting events into osc messages. These osc messages contain the timing information required by the SuperDirt synth to play them when they are expected. The scheduling process repeats this operation every 1/20th of a second - collecting all the events for that time period, converting them to osc, and sending them over the network to SuperDirt (or other synth target). In order to accomplish this we need the following:
- a clock (a way of scheduling functions in time)
- a way of converting patterns to osc message streams
- a way of sending osc messages

## how does vortex accomplish this?
vortex, in the `stream.py` file, implements a class called `LinkClock`. `LinkClock` interfaces with the AbeltonLink api for synchronising with external music applications. Inside this class is a private method `_notify_target_thread`. This method is spun off to a new thread when start is called on the clock. It uses a thread sleep in a while loop internally for timing. Each iteration of the loop communicates the tempo via AbeltonLink and notifies subscribing streams. The streams are then responsible for converting patterns to osc and sending over the network to the Synth Target.

## how does strudel accomplish this?
strudel, in the `Cyclist.mjs` file defines a `Cyclist` class. This class collaborates with a clock (defined in `zyklus.mjs`) to schedule events (called `hap` in strudel) in time. On each tick of the clock, the `Cyclist` queries its pattern and fires a function `onTrigger` that is specified during construction by the caller. In the `repl.mjs` file, a `Cyclist` is created and an `onTrigger` behavior is specified. The `repl` specifies an on trigger that then `awaits` a function called `defaultOutput`. This function is passed the event and the timing info when called. If the `context` of the event contains an `onTrigger` function this is used instead of `defaultOutput`. `defaultOutput` is specified on construction of the `repl`. When the react application that defines the web ide starts it sets defaultOutput to the `webAudioOutput`. The web audio output directly uses the events. In this configuration, no osc messages are produced. I believe that strudel can be configured to communicate with SuperDirt over the network as well and had osc classes in its library.

## how does tidal accomplish this?
For mainline tidal, the `stream.hs` module defines the following:
- A data type called `Target` that contains the network configuration for an OSC target.
- A type called stream
- several functions for converting configuration data into `IO Stream`.
- several functions mapping `Stream -> IO`. These functions send OSC messages.
- `toOSC :: [Int] -> ProcessedEvent -> OSC -> [(Double, Bool, O.Message)]`. I think this is part of what converts events to OSC. `ProcessedEvent` is some intermediate type.

## how should tranquility accomplish this?
### 2023-01-27
Vortex might be easier to imitate at first as its implementation is simpler. Added complexity could be layered in later. The project already makes use of `LuaSocket` as part of its dependence on `losc` for sending osc messages. (This might need to be revisited as vortex uses `liblo`. It might be best to attempt to use the same libraries as others when possible. ) `LuaSocket` provides a sleep method `socket.sleep(time)`. Perhaps coroutines could be used to spin up a clock process that sleeps internally this way to create the 1/20 sample rate for querying patterns. A function for converting events to osc messages will need to be created.

### 2023-02-02 - coroutines

Co-routines are a pattern for accomplishing cooperative multitasking. In cooperative multitasking, the program never cedes control of its run to an external party and concurrency is accomplished by explicit task switching in the program. Co-routines (cooperative routines), are sub-routines that can suspend their operation and *yeild* program flow back to the caller without returning. The caller can then *resume* the co-routine until it completes or *yeilds* again. This trades away the ability for true parallelism for more determinism is program flow while still providing concurrency.

If tranquility is going to use this style of concurrency to accomplish multitasking between pattern parsing and sending osc messages, there will need to be some explicit part of the program in charge of this task switching. What if there were a scheduler process that switched between these two tasks? How could the tasks be defined? The clock/osc message process is more clear. There is a method on the subscribing `Stream` that is called by the publishing `Clock`. The `Clock` could return a co-routine when started that a `Scheduler` could repeatedly call. What about the other half of the tasks? How can the process of stream creation be defined as a co-routine that is called by this scheduler. Right now there is a global function `p` that adds processes to a global `Stream` map and starts the clock. These pieces of state (`Streams` and `Clock`) would need to be managed by the scheduler. But where does the user input come from that calls `p`? Could some `DSL` context be exported that would poll for new user input and then `yeild`? This would mean that there would be a good deal of busy-waiting... is there a better design that utilizes co-routines? Is it better to try an accomplish true parallelism?

For tomorrow, I should try and make a lua script that makes a pattern `Pure("gabba")` and starts a clock with a stream of this pattern. Hopefully, this will create a distorted kick drum once per cycle and we will be at "gabba zero". *:)*
