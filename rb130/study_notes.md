# Blocks

## Closures and Scope

**Closure** is a general programming concept that allows programmers to save a **chunk of code** and execute it a later time. The main comes from being able to pass this *chunk of code* into anywhere, specifically into existing methods.

Closures bind to its surrounding artifacts such as variables, methods and objects. It builds an **enclosure** around these objects which were in the scope at the time and the location the closure was created.

As part of the concept of **binding** it is crucial to understand how variable scope works(as well as method references, constants and other artifacts). By having an understanding over the time we initialise a local variable and its scope, we can better define the surrounding context of the closures.

There are 3 main ways to work with closures in Ruby:

1. Instantiating an object from the **Proc** class.
2. Using **lambdas**
3. Using **blocks**

