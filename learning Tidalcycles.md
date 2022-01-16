# Learning Tidalcycles

Here are my notes about learning [Tidalcycles](Tidalcycles) and the parts of the language that I find most inspiring.

### Shifting poly-meters
I learned this one from watching a [kindohm](https://www.kindohm.com/) [livestream](https://www.youtube.com/watch?v=SRDb8rSijVA)... 
The basic idea is to use poly-rhythms of various lengths to create shifting patterns that take a very long time to repeat. 

Here is an example of a pattern with a poly-metric rhythm using the tidal mini notation:
```
d1 $ n ("{2@5 7@5 0@1 0@2 0@2}%16") #s "peri"
```

The poly-metric part is the `"{2@5 7@5 0@1 0@2 0@2}%16"`. Lets break this down. The `%16` part of the phrase declares that a cycle has 16 length units in it. The `@` symbol sets the length of the event where the left-hand argument is the event value and the right-hand value is the length. The first 16 units worth of events will play in the first cycle, then next 16 in the next, and so on. The leftover/shortfall events spillover into the next cycle creating a pattern that shifts against the cycle. The sum of the length values in the pattern above is 15, therefor it will begin to repeat before the next cycle begins. It will take 16 cycles for this pattern to line up with the cycle start again. 

When you combine poly-meters of various lengths it can take a *very* long time for them to precisely repeat. This fact can be a good source of variation in a repeating pattern. 

If you wish to constrain this variation to some cycle length the `timeLoop` function can be used.

### Pattern the pulse
One of the coolest parts of tidal is that you can manipulate the underlying pulse using patterns. Tempo shifting is very easy. Tidal exposes `cps` or *cycles per second* as a pattern parameter. The following pattern speeds up over 4 bars in a repeating ramp pattern.
```
d1 $ s "bd(5,8)" #cps (range 80 100 $ slow 4 $ saw)
```
I find this kind of tempo manipulation to be really expressive and under-explored in electronic dance music. 

### Other time manipulation functions

`ply` - The `ply` function repeats each event a given number of times. Patterning the *number-of-repetitions* parameter can lead to a feeling of expanding and contracting time, even as the underlying pulse remains even.

`stripe` - The `stripe` function will randomly change the speed of a pattern such that it lines back up with the main cycle pulse after a given number of cycles. The effect is really fascinating.


#### backlinks
- [Algorithmic Music](Algorithmic Art)
