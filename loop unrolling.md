# Loop Unrolling
Loop unrolling is an optimization that is typically made by the compiler, although it can be manually accomplished in assembly. When an iteration occurs in the code, and the number of times the iteration loops is known at compile time, the loop can be unrolled. Unrolling the loop means replacing the iteration instruction with hard-coded instructions for each iteration one after the other. For example, consider the following loop:
```
for (size_t index=0; index<3; index++){
	std::cout<<index;
}
```

The unrolled version is:
```
std::cout<<1;
std::cout<<2;
std::cout<<3;
```

Since we know we are going to loop 3 times when we compile, we can replace the loop with hard-coded instructions. The resulting assembly is much faster than conditionally looping. 