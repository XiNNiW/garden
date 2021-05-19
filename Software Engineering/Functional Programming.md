---
---
# Functional Programming
Functional Programming is a paradigm for software design. It favors implementing functionality by composition of pure function and demands that side effects be strictly separated from [pure](pure function.md) functional code.

This pure code has [[Referential Transparency]] and it is possible to reason about its behavior mathematically.

## common features
The following are generally common to functional design. However, not all languages have built in support for these concepts. Trying to keep code pure can be puzzling as a computer program is inherently useless until it produces some tangible side effect. The following language features generally make this puzzle easier to solve.

-[[Closures]]
-[[Partial Application]]
-[[Lazy Evaluation]]