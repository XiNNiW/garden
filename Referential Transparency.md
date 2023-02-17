# Referential Transparency
:cc0:

Often discussed in conjunction with the paradigm of [Functional Programming](Functional Programming), Referential Transparency is the property of pure functions that always guarantees the same return value for a given set of arguments. When a function is pure, it has no side effects, and relies on only the values of its arguments to determine the return value. This means that you will always receive the same return value for a given set of arguments. 

This property is extremely useful when:
- **Unit Testing:** Referential transparency enables "black box" testing of a function or composition of functions. Cases are depended on only input and output data, they require no mocking, and are generally more simple to reason about. These tests only care about the implementation details in so far as they effect the return value.
- **Designing Code:** The guarantee of consistent behavior makes it easier to reason about the behavior of the code under a variety of circumstances and isolates the code from the world of things that may fail or misbehave. (eg. filesystems, Networks, other processes, ect...) Additionally it makes it safer to compose the functionality of functions together, which is helpful in designing more complicated algorithms from simple parts.
- **Concurrency:** Referential transparent code never mutates outside values and instead deals with copies. In many circumstances this makes it easier to share a data boundary with some asynchronous concurrent process without resorting to mutex locks and risking deadlock scenarios.

In my opinion, Referential Transparency is the most important property of functional design and is also the most simple to translate to languages that are not specially designed for functional programming. It is possible to create referential transparent code that is not dependent on specialized language features such as [Partial Application](Partial Application), [Tail Call Optimization](Tail Call Optimization), or [Lazy Evaluation](Lazy Evaluation).
