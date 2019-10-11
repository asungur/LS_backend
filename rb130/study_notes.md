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
## Methods with an explicit block parameter

Already discussed above, but lets test this concept with a simpler example:

```ruby
def test(&block)
  puts "What's &block? #{block}"
end

test { "I'm a lonely block!" }    #=> What's &block? #<Proc:0x000000000231cf98...>
```
This shows how '&block' keyword converts the given block to a Proc object. We can execute the block by calling `Proc#call` method:

```ruby
def test(&block)
  puts "What's &block? #{block.call}"
end

test { "I'm a lonely block!" }    #=> What's &block? I'm a lonely block!
```
While we can not do anything other than **yielding** an implicit block, we can make use of explicit block by passing it into another method.

```ruby
def test(block)
  puts "What's &block? #{block.call}"
end

def test2(&block)
  puts "Step 1"
  test(block)
  puts "Step 3"
end

test2 { "I'm a lonely block!" }  #=> Step 1 \n What's &block? I'm a lonely block! \n Step 3

```

## Arguments and return values with blocks

The rules around enforcing the number of arguments you can call on a closure in Ruby is called **arity**. These rules differ between **Proc objects**, **lambdas** and **blocks**.

Blocks are more forgiving in terms of arity. Unlike method definitions they will not raise `ArgumentError` when different number of arguments are passed in.

```ruby
def test
  yield('object1', 'object2')
end

test { |obj1, obj2| p obj1, obj2 }                # => 'object1' 'object2'
test { |obj1, obj2, obj3| p obj1, obj2, obj3 }    # => 'object1' 'object2' nil
test { |obj1| p obj1 }                            # => 'object1'
```
At the above code, we defined a `test` method that yields the block and passes in two arguments; string objects `'object1'` and `'object2'`.

There are three tests:
  * At the first case we provided equal amount of arguments to number of parameters of the block. This is the ideal scenario
  * At the second case, method yields the block with two arguments where as the block has two parameters. The value `nil` will be assigned to `obj3` and no exception will be raised.
  * At the last case, `yield` passes in more arguments than the parameters defined by the block. This will not raise an exception and the arguments will be assigned to block paramters in the given order. Since `object1` is the first argument passed in by `yield` it will be assigned to `obj1`.

## Symbol to proc

When working with collections, we often want to do mass manipulations on the whole data set. An example:

```ruby
[1, 2, 3, 4, 5].map { |num| num.to_s }             # => ['1', '2', '3', '4', '5']
```
There is a shortcut into that
```ruby
[1, 2, 3, 4, 5].map(&:to_s)                        # => ['1', '2', '3', '4', '5']
```
Lets look into the process that converts `(&:to_s)` into `{ |num| num.to_s }`
1. When we prepend and object with `&`, Ruby try to convert it into a block. It does this by calling `#to_proc` unless the given object is a Proc object.
2. Since `:to_s` is a symbol not a proc, Ruby will call `Symbol#to_proc` method on this.
To sum up, `:to_s` symbol first converted to a proc, then converted to a block which results into `{ |n| n.to_s }`


# Testing with Minitest

## Testing terminalogy

**Regression testing** is the primary reason that we write tests. These check for bugs that occur in formerly working code after any changes been made in the codebase. By using predefined tests to check for bugs we don't have to verify everything manually after changing the codebase.

**Assertion** is a verification step to confirm that the results returned by a program or application match the expected results.
**Test Suite** is a group or set of situations or contexts within which verification checks are made.
**Test** is a situation or context in which verification checks are made. For example, making sure you get an error message after trying to log in with the wrong password. May require multiple steps.

## Minitest vs RSpec

**RSpec** uses Domain Specific Language (DSL) for writing tests. It is a popular application as it allows users to write code that reads like a natural English

**Minitest** uses Ruby and it is included in later versions of Ruby.

## Seat Approach

**SEAT Approach** is a testing methodology to optimise test workflow by automating redundant steps. It consists of following four steps:

  * **S**et up the necessary objects.
  * **E**xecute the code against the object we're testing.
  * **A**ssert the results of the execution.
  * **T**ear down and clean up any lingering artifacts.

## Assertions

**Assertion** is a verification step to confirm that the results returned by a program or application match the expected results.

We can test **equality** by using 'assert_equal'. This will call `==` method on the object. However to test if the objects are the same we use `assert_same` assertion

## Code coverage

Code coverage is a metric to assess code quality. It measures how much of a program is tested by a test suite.

# Core Tools/ Packaging Code

## Purpose of Core Tools

  * **Bundler** Lets you manage the various dependencies in a Ruby project.
  * **Rake** Automates common functions required to build, test, package, and install programs.
  * **RVM** and **Rbenv** Lets you install, manage, and use multiple versions of Ruby.
  * **Rubygems** are packages of code that you can download, install, and use in your Ruby programs or from the command line.

We use `bundle exec` to deal with the conflict between the gem versions in use and `Gemfile.lock` versioning info. `bundle exec` will make sure that the gems specified in the Gemfile are available to our program.

