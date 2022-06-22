# Sample project execution

You must install xcodegen to generate .xcodeproj to run the sample project. 

More infos at: https://github.com/yonaskolb/XcodeGen

Run cmd 'xcodegen' in terminal at root project sample folder (where .yml file is).

# S.O.L.I.D. 
### The Principles of acronym OOD (object-oriented design) by Robert C. Martin 

SOLID letters is a part of five principles, which puts your code on a high level. 

It must be practiced and have been used by expert engineers at any kind of application.

Systems present a nice clean code and turn an easy way to change and build through trade-offs to its respective architectures.

#### Single Responsibility Principle (SRP)

It says that a class must have ONE reason to make something. That's why, you should have to think about to abstract responsibilities between your system's classes.

```swift
protocol IBuyer {
    func buy(crypto: ICripto, id: String)
}

protocol ISeller {
    func sell(crypto: ICripto, id: String)
}

protocol IExchange {
    var wallets: [IWallet] { get }
    func find(id: String) -> IWallet?
}

// I'm an exchange and I only do operations Buy/Sell into a wallet list
struct Exchange: IExchange, IBuyer, ISeller {
    var wallets: [IWallet]
    
    init(wallets: [IWallet]) {
        self.wallets = wallets
    }
    
    func find(id: String) -> IWallet? {
        return wallets.first(where: {$0.id == id})
    }

    func buy(crypto: ICripto, id: String) {
        if var input = find(id: id) {
            input.add(crypto: crypto)
        }
    }
    
    func sell(crypto: ICripto, id: String) {
        if var input = find(id: id) {
            input.remove(crypto: crypto)
        }
    }
}

protocol IWallet {
    var id: String { get }
    var cryptos: [ICripto] { get }
    mutating func add(crypto: ICripto)
    mutating func remove(crypto: ICripto)
}

// I'm a wallet and I only know how to manage a crypto list.
struct Wallet: IWallet {
    var id: String
    var cryptos: [ICripto]
    
    init(id: String) {
        self.id = id
        self.cryptos = []
    }
    
    mutating func add(crypto: ICripto) {
        cryptos.append(crypto)
    }
    
    mutating func remove(crypto: ICripto) {
        if let index = cryptos.firstIndex(where: {$0.id == crypto.id}) {
            cryptos.remove(at: index)
        }
    }
}

protocol ICripto {
    var id: String { get }
    var name: String { get }
}

// I'm a crypto model
struct Crypto: ICripto {
    var id: String
    var name: String
}

```

#### Open Close Principle (OCP) 

It says that you should not modify your class inside. You should create extensions and change it by out-side. 

It doesn't mean extension in Swift! It's creating another abstraction and implementation for your problem without breaking the solution, using good practices for the acronym POP (protocol-oriented programming).

```swift

protocol IPrinter {
    var logger: String { get }
    func print() -> String
}

protocol ILog {
    var log: IPrinter { get }
    func execute()
}

struct Log: ILog {
    var log: IPrinter
    
    func execute() {
        print(log.print())
    }
}

struct AnalyticsLog: IPrinter {
    var logger: String
    
    func print() -> String {
        return "I'm an Analytics Log - " + logger
    }
}

struct NetworkLog: IPrinter {
    var logger: String

    func print() -> String {
        return "I'm a Networking Log - " + logger
    }
}

```

#### Liskov Substitution Principle (LSP)

It says that every part of parent's class inheritance by sub-classes must be used and cannot break them.

A simple easy example is a DOG class inheritances a CAT class, just because they both walk or whatever. It brings useless functions to subsclas and behaviors are totally different, which could presents system's flaw.
 
As a conclusion fact, Liskov Principle gives us an alert! Don't simple use a inheritance because it seens nice or you think reuse just some functions. Besides, be fascinate with usage of protocols and a good abstraction than inheritances.

#### Interface Segregation Principle (ISP)

Don't create long interfaces or even functions that would not being used on implementation class.

Segregation means part your interfaces into small sections of abstraction. Following it would be the easiest way to conquer this principle :)

#### Dependency Inversion Principle (DIP)

It's basically that high classes and low classes should not depends to each other. They should depends from an abstraction. 

This way, your system could easily be changed by injecting diferents classes that implements the same protocol.

Here, we can also see the pattern dependency injection, which could be implemented by different ways.
