# A Fantasy Virtual Machine for Music

What would a sustainable environment for computer music look like? 

It would have to balance the following constraints:
- Portability to a large variety of old and scavenged hardware
- Enough precision to achieve acceptable sound complexity
- Enough speed to render multiple voices of sound and complete audio editing and sound design tasks

The goal would be to make an instrument that one would be happy playing for the rest of one's life. This property is expected of violins, guitars, pianos and other traditional instruments. How could this property be extended to digital instruments? This is a larger question with many cultural, and sociological implications. For now lets explore the simple technical questions. A digital instrument like the one described above would have to balance novelty, and quality against hardware that are as limited as possible. The more limited the hardware specifications targeted, the more likely this instrument will be able to be emulated far into the future on whatever hardware is available. It is important here to specify what [model of future computing](model of future computing) one wishes to use. For example, should this digital instrument be designed to weather a total collapse of the supply chains that make computers possible? Should it instead model a future defined by a literal interpretation of Moore's Law and assume that future hardware will be faster, better, and therefor capable of emulating any system designed now?  

These constraints are obviously in tension with each other. An acceptable polyphony of voices using high sample rates and large bit depths requires fast processing speeds. Powerful sampling capabilities and large numbers of tracks require large amounts of RAM. Finally the GUI environment that popular music software runs inside of has become more resource intensive. At first glance it seems like the modern concept of a DAW really only became possible with the advent of SIMD instruction sets. If this is set as a requirement, it severely limits portability to older hardware. However, I'm not so sure that these high flying specs really are required in order to make a computer instrument that one could happily spend the rest of their life playing.

I believe it is possible to create a digital instrument flexible enough for many lifetimes of exploration within fairly modest computational limits.

# Technical requirements of popular music tools of the past
It may be useful to look at historical music software and think about its minimum operating specs and the breadth of features offered within those limitations.

| Software                                                     | CPU     | RAM   | Feature Set                                                  |
|--------------------------------------------------------------|---------|-------|--------------------------------------------------------------|
| [Abelton Live v.1.5](Minimum requirements: Abelton Live 1.5) | 300 MHZ | 64MB  | Recording, editing, sample warp, audio effects               |
| Abelton v.4                                                  | 600 MHZ | 256MB | midi, synthesis, clip envelopes, multitrack recording        |
| GarageBand v1                                                | 600 MHZ | 512MB | Recording, editing, synthesizers, audio effects, midi        |
| Abelton v.5                                                  | 600 MHZ | 512MB | +complex warp, delay compensation, 24-bit /192 kHz recording |
| MaxMSP v.4                                                   | 1GHZ    | 512MB | arbitrary graphical programming for sequencing and synthesis |
