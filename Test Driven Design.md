# Test Driven Design
Also called [[Test Driven Development]] 

Test Driven Design (or TDD for short) is a methodology for software design process where automated unit tests for a given function or module of code is written before the production code is written. The process works as follows:
1. Write a unit test that verifies the aspect of the code's behavior you wish to add to the production module/function.
2. Run it to verify it fails properly when that behavior is absent. (This may involve adding enough production code for the test to compile).
3. Write the smallest amount of production code necessary to get your unit test to pass.
4. Repeat with new behavior.

This process is also known as Red-Green-[[Refactor]] as you first get a test failure (Red), then a test pass (Green), and then you may change the structure of your code again ([[Refactor]]). 

This process works very well when combined with [[paired programming]]. The different stages provide convenient moments in time to share the control of the keyboard and mouse. The process of devising the test together is also an excellent way to come to a shared understanding of the behavior you are both aiming to create.


Although its is most widely known as [[Test Driven Development]] the benefit of the practice is more clearly articulated by the name Test Driven Design. Test writing is a process for understanding the code you mean to write, sharing that understanding with the computer, and with other humans.