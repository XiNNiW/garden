# Sustainable Computing

Given how the supply chain for computers is creating massive ecological harm, is there any way to create a more 
sustainable way of computing.

The most sustainable computer is the one you already own. Therefore, sustainable computing must include software specifically designed to be performant on a wide variety of older hardware. 

### portability

Software written against particular hardware is difficult to make portable. The abstraction offered by a virtual machine can insulate software logic from the specifics of a given piece of computer hardware. The most ecologically sound computer hardware will be scavenged or upcycled making the number of devices that need unique support is potentially very large.
Therefore, this virtual machine must remain small enough to be easy to implement by a single person within a few weeks of effort.
This need for simplicity is in conflict with the features that would be most useful for such a machine.
Given hardware variability, system interaction should degrade gracefully when hardware features are not present. End-user facing software should take into account a large number of alternate input and interaction methods. 

Software may also need to consider the possibility that the hardware may prefer 8, 16, 32, or 64 bit numbers. Systems like *hundredrabbit's* *UXN* circumvent this problem by only including 8bit numbers. This limitation makes it incredibly difficult to compute real-time audio, however. I think [a different balance between these trade-offs](fantasy virtual music machine) would need to be struck to create a sustainable computer music environment. 

The system I am imagining may need to present numerical types and sizes in a way that allows the use of larger types, if available. It should also provide the capacity to fail over gracefully to smaller types. Small number sizes should be preferred where practical. Numerical types may need to be templated and alternate code written for each size.

### dependency

Software dependencies should be carefully vetted for potential platform restrictions. Potentially

### resource utilization

Resource utilization should be as minimal as possible. Software should potentially be written to adapt to different resource profiles, providing different feature implementations for each level.
