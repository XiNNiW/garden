# Partial Application
Related to [closures](Closures), Partial application is the idea that, when supplying less than the required number of arguments for a function, it should not create an error, but rather return a closure that "encloses" over the partially applied arguments. This function then would take the missing arguments as its input and call the original function with all the data together. It is not a common feature outside of pure functional languages like `Haskell`. However, some languages have add on libraries to simulate this effect.

The ability to partially apply functions makes it easier to compose functions together.
