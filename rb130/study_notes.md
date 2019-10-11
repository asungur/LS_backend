# Blocks

## Closures and Scope

**Closure** is a general programming concept that allows programmers to save a **chunk of code** and execute it a later time. The main comes from being able to pass this *chunk of code* into anywhere, specifically into existing methods.

Closures bind to its surrounding artifacts such as variables, methods and objects. It builds an **enclosure** around these objects which were in the scope at the time and the location the closure was created.

As part of the concept of **binding** it is crucial to understand how variable scope works(as well as method references, constants and other artifacts). By having an understanding over the time we initialise a local variable and its scope, we can better define the surrounding context of the closures.

There are 3 main ways to work with closures in Ruby:

1. Instantiating an object from the **Proc** class.
2. Using **lambdas**
3. Using **blocks**

## How do blocks work and where we want to use them?

Blocks are commonly used in Ruby by passing in `{ ... }` or `do ... end` into methods as arguments. Every method in ruby can take block arguments, but it's implementation is what's important and makes the difference.

```ruby
def hello
  "hello!"
end

hello                       # => "hello!"
hello("hi")                 # => ArgumentError: wrong number of arguments (1 for 0)
hello { puts 'hi' }         # => "hello!"
```
Passing an implicit block is different than passing an argument to a method. In the above code, `hello { puts 'hi' }` will not raise an error, however since the use of block is not defined, it will not have an impact on the return value of the method.

```ruby
def hello
  "hello! " + yield
end

hello { 'hi!' }         # => "hello! hi!"
```
**yielding** is one of the ways we can execute the block argument passed-in to our method. We do this by using `yield` keyword. In the above code, `yield` executes the block which returns the string object with the value `hi!"`. This will be added to `"hello! "` string object and returned by the method `hello`.

There two common use scenarios of **blocks** in ruby.

1. Leaving implementation decisions ot method invocation time. We can create generic methods which can have a variety of uses.

```ruby
my_arr = %w(Moya tim Jonathan)

my_arr.select { |name| name.size > 3}
my_arr.select { |name| name == name.capitalize }
```
`Array#select` method is a good example of scenario 1. Only rule defined by this method is that it passes each object to the given method block and appends the object into a new array if the return value of the block is truthy.

2. **Sandwich code** use when we need before and after actions.

```ruby
def modify_text_file
  # open the file
  yield # implement block
  # close the file
end
```

## Blocks and Variable Scope

Blocks can keep track of variables, constants and methods that are in the same scope with the block. By keeping track of the **binding** , blocks have all the information ready in case it needed during the execution of the code.

```ruby

my_str = '231249120awds'

def test(str)
  str + '.1132'
end

my_arr = [1, 2, 3 ]

def modify(arr)
  arr.map { |item| yield(item) }
end

modify(my_arr) do
  # do sth
end
```
For instance, in the example above all `my_str`, `test` method, `my_arr` and `modify` method are part of the **binding**

## Write methods that use blocks and procs (and lambdas)

  * **Lambdas** are instances of **Proc** class. In other words both are **Proc** objects. An implicit block is a **chunk of code** and is not an Object. It is type of closure.

  * **Lambdas** enforce the number of arguments passed to them. Implicit blocks and **Procs** do not enforce the number of arguments passed in.

  * When we pass blocks **explicitly** as an argument to a method, we automatically convert it to a proc. We use `&block` to do that. Then we use `Proc#call` method to execute the code in the initial block. To execute **implicit** blocks we use `yield`.

  * One of the main advantages of passing in Proc objects is that we can call multiple **Proc** objects in the same method.

For instance:
```ruby
def test1(proc1, proc2)
  puts "We are #{proc1.call} and #{proc2.call}."
end


def test2
  puts yield
end

a = Proc.new { "the first proc" }
b = Proc.new { "the second proc" }

test1(a,b)                              # => We are the first proc and the second proc.
test2 { "I'm a lonely block." }         # => I'm a lonely block.
```
