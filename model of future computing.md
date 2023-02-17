#Permacomputing: Modelling the future of computing

The design of computational systems that can be preserved into the far future, like any design problem, is predicated on a set of expectations about the future. These expectations inform the design requirements and the scenarios against which a candidate design must be tested. 

Discussions about permacomputing that I have observed tend to assume one of the following models of the future.

# Collapse
A popular model to assume is one of complete civilizational collapse. In this future, the complex supply chains that underpin modern computing are destroyed by some combination of climate instability, war, famine, pandemic or some other such host of apocalyptic problems. Computers, in so far as they are still used, must be entirely scavenged from existing machines. Through hole components would be prized in this scenario as they are easiest to de-solder. 

A designer operating under this set of assumptions would likely design for the performance profile of 8bit computers of the 80's as this models the kind of hardware that would be available for easy scavenging. In addition to severely limiting the required operating specifications, she might also consider targeting a small lightweight virtual machine that could be ported to some improvised computer hardware with minimal effort.

### examples of design that assumes the collapse model

- [Collapse OS](http://collapseos.org/)
- [UXN](https://wiki.xxiivv.com/site/uxn.html)

# Moore's Law Forever
Another popular model is to assume that Moore's law continued unabated into the distant future. This model has been prevalent in popular discourse surrounding the future of technology for many years. This model is often an underpinning assumption made by futurists interested in AI, singularity, other imagined futures where computational power becomes a god-like force.

A designer operating under this vision of the future need not limit themselves in any way as computers of the future will be arbitrarily powerful. 

This view of Moore's law seems increasingly implausible as the trajectory of computational power has sagged in recent decades.

A more careful designer who still assumes a future of increasingly powerful machines would still need to make considerations that limit the complexity of their design. In this future, the tools of the past would be unable to run, not because sufficient hardware is unavailable, but because the secrets required to build and extend its tooling have been forgotten.
This designer may therefor still choose to place hard limits on the software she designs with the goal of making it possible for people in the far future to emulate her computational environment without undue effort. 

# A 3rd model: Responsible design
To this set I would like to include a 3rd model. In this vision of the future, we come to our senses and realize that we must radically alter our behavior in order to survive as a species. As part of this change, we realize that manufacturing every more powerful and complicated computers (which consumes ever greater amounts resources), only to throw them away a few years into their useful life to replace them with newer, even more complicated machines, is not sustainable. 

If this cycle of obsolescence was broken, what might we do instead?

If we were to prioritize impact on our shared environment while still continuing to use computers in our lives, we would likely design these devices to last as long as possible, repair them when they broke, and design software to run on an extremely large number of possible hardware platforms. 
How long would a computer need to last in order to mitigate the environmental impact of its manufacture? For the sake of argument, lets say that this figure is 25 years.

In this world, software designers would seek to avoid inadvertently forcing an end user to replace a working computer with a faster one. They might do this in the following ways:
- Designing for some absolute minimum set of specifications
- Designing graceful fail-overs for complicated features

Here too, the idea of designing against some minimal virtual machine is appealing as it enables support for a wider variety of hardware platforms.
