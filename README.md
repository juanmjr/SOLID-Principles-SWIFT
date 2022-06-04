# S.O.L.I.D. 
### The Principles of acronym OOD (object-oriented design) by Robert C. Martin 

SOLID letters is a part of five principles, which puts your code on a high level. 

It must be practiced and have been used by expert engineers at any kind of application.

Systems present a nice clean code and turn an easy way to change and build through trade-offs to its respective architectures.

#### Single Responsibility Principle (SRP)

It says that a class must have ONE reason to make something. That's why, you should have to think about to abstract responsibilities between your system's classes.

#### Open Close Principle (OCP) 

It says that you should not modify your class inside. You should create extensions and change it by out-side. 

It doesn't mean extension in Swift! It's creating another abstraction and implementation for your problem without breaking the solution, using good practices for the acronym POP (protocol-oriented programming).

#### Liskov Substitution Principle (LSP)

It says that every part of parent's class inheritance by sub-classes must be used and cannot break them.

A simple easy example is a DOG class inheritances a CAT class, just because they both walk or whatever. It brings useless functions to subsclas and behaviors are totally different, which could presents system's flaw.
 
As a conclusion fact, Liskov Principle gives us an alert! Don't simple use a inheritance because it seens nice or you think reuse just some functions. Besides, be fascinate with usage of protocols and a good abstraction than inheritances.

#### Interface Segregation Principle (ISP)

Don't create long interfaces or even functions that would not being used on implementation class.

Segregation means part your interfaces into small sections of abstraction. Following it would be the easiest way to conquer this principle :)

#### Dependency Inversion Principle (DIP)

