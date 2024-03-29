# Lazy Evaluation
:cc0:

 Many functional languages enable code to be evaluated lazily by default. This means the code is not executed until the moment when the final return value is needed for interaction with the outside world. This enables functions to manipulate otherwise impossible data structures, such as infinite lists, so long as, by the time the final call is made, the functions are composed in such a way the limits the size of the data. Lazy evaluation pairs well with closures and partial application in enabling the programmer to compose functionality together.
