# Closures 
Closures are a way of treating a function as an object. Functional language generally let the programmer define anonymous functions that "enclose" data that is needed for their function. These functions can then be composed with others to form larger structure. For example, consider the following `js` function:
```
function saySomthing(something) {
	return ()=>"say" + " " + something;
}
```
The function `saySomething` "encloses" the value something and then returns a function that, when called returns the value of something concatenated with the string "say".