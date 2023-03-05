[![how-to](https://img.shields.io/badge/how--to-use-blue.svg)](https://github.com/yonaskolb/XcodeGen)

You must install xcodegen to generate .xcodeproj to run the sample project. 

Run cmd 'xcodegen' in terminal at root project sample folder (where .yml file is).

# Support languages
[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/juanmjr/SOLID-Principles-SWIFT/README.md)
[![pt-br](https://img.shields.io/badge/lang-en-green.svg)](https://github.com/juanmjr/SOLID-Principles-SWIFT/README.pt-br.md)

# S.O.L.I.D. 

<p align="center">
  <img src="https://github.com/juanmjr/SOLID-Principles-SWIFT/blob/feature/solid-image/solid.png" />
</p>

<p align="center">
   The Principles of acronym OOD (object-oriented design) by Robert C. Martin 
</p>

<br/>

SOLID letters is a part of five principles, which puts your code on a high level. 

It must be practiced and have been used by expert engineers at any kind of application.

Systems present a nice clean code and turn an easy way to change and build through trade-offs to its respective architectures.

#### Single Responsibility Principle (SRP)

It says that a class must have ONE reason to make something. That's why, you should have to think about to abstract responsibilities between your system's classes.

```swift
protocol BuyerProtocol {
    func buy(crypto: CryptoProtocol, id: String)
}

protocol SellerProtocol {
    func sell(crypto: CryptoProtocol, id: String)
}

protocol ExchangeProtocol {
    var wallets: [WalletProtocol] { get }
    func find(id: String) -> WalletProtocol?
}

// I'm an exchange and I only do operations Buy/Sell into a wallet list
final class Exchange: ExchangeProtocol, BuyerProtocol, SellerProtocol {
    var wallets: [WalletProtocol]
    
    init(wallets: [WalletProtocol]) {
        self.wallets = wallets
    }
    
    func find(id: String) -> WalletProtocol? {
        return wallets.first(where: {$0.id == id})
    }

    func buy(crypto: CryptoProtocol, id: String) {
        if var input = find(id: id) {
            input.add(crypto: crypto)
        }
    }
    
    func sell(crypto: CryptoProtocol, id: String) {
        if var input = find(id: id) {
            input.remove(crypto: crypto)
        }
    }
}

protocol WalletProtocol {
    var id: String { get }
    var cryptos: [ICripto] { get }
    func add(crypto: CryptoProtocol)
    func remove(crypto: CryptoProtocol)
}

// I'm a wallet and I only know how to manage a crypto list.
final class Wallet: WalletProtocol {
    var id: String
    var cryptos: [CryptoProtocol]
    
    init(id: String) {
        self.id = id
        self.cryptos = []
    }
    
    func add(crypto: CryptoProtocol) {
        cryptos.append(crypto)
    }
    
    func remove(crypto: CryptoProtocol) {
        if let index = cryptos.firstIndex(where: {$0.id == crypto.id}) {
            cryptos.remove(at: index)
        }
    }
}

protocol CryptoProtocol {
    var id: String { get }
    var name: String { get }
}

// I'm a crypto model
final class Crypto: CryptoProtocol {
    var id: String
    var name: String
}

```

#### Open Close Principle (OCP) 

It says that you should not modify your class inside. You should create extensions and change it by out-side. 

It doesn't mean extension in Swift! It's creating another abstraction and implementation for your problem without breaking the solution, using good practices for the acronym POP (protocol-oriented programming).

```swift

protocol PrinterProtocol {
    var logger: String { get }
    func print() -> String
}

protocol LogProtocol {
    var log: PrinterProtocol { get }
    func execute()
}

final class Log: LogProtocol {
    var log: PrinterProtocol
    
    func execute() {
        print(log.print())
    }
}

final class AnalyticsLog: PrinterProtocol {
    var logger: String
    
    func print() -> String {
        return "I'm an Analytics Log - " + logger
    }
}

final class NetworkLog: PrinterProtocol {
    var logger: String

    func print() -> String {
        return "I'm a Networking Log - " + logger
    }
}

```

#### Liskov Substitution Principle (LSP)

It says that every part of parent's class inheritance by sub-classes must be used and cannot break them.

A simple easy example is a DOG class inheritances a CAT class, just because they both walk or whatever. It brings useless functions to subsclass and behaviors are totally different, which could presents system's flaw.
 
As a conclusion fact, Liskov Principle gives us an alert! Don't simple use a inheritance because it seens nice or you think reuse just some functions. Besides, be fascinate with usage of protocols and a good abstraction than inheritances.

```swift

import UIKit

protocol BaseLoadingProtocol {
    var loadingIndicator: UIActivityIndicatorView? { get }
    func showLoadingIndicator(view: UIView)
    func hideLoadingIndicator()
}

protocol BaseNavigationProtocol {
    var navigationTitle: String? { get }
    func setNavigation()
}

class BaseViewController: UIViewController, BaseLoadingProtocol, BaseNavigationProtocol {
    var loadingIndicator: UIActivityIndicatorView?
    var navigationTitle: String?
    
    func showLoadingIndicator(view: UIView) {
        if let loadingIndicator = loadingIndicator {
            view.addSubview(loadingIndicator)
            loadingIndicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        if let loadingIndicator = loadingIndicator {
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.tintColor = .red
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = navigationTitle
    }
}

protocol MyViewControllerProtocol {
    func setup()
}

final class MyViewController: BaseViewController, MyViewControllerProtocol {
    
    func setup() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator?.color = .red
        navigationTitle = "Hi World :)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setNavigation()
    }
}

```

#### Interface Segregation Principle (ISP)

Don't create long interfaces or even functions that would not being used on implementation class.

Segregation means part your interfaces into small sections of abstraction. Following it would be the easiest way to conquer this principle :)

```swift

protocol ResultSuccessProtocol {
    func successBlock()
}

protocol ResultErrorPersonNotFoundProtocol {
    func personNotFoundBlock()
}

protocol ResultErrorEmailNotFoundProtocol {
    func emailNotFoundBlock()
}

protocol ResultErrorDefaultProtocol {
    func defaultErrorBlock()
}

final class IJustWantSuccess: ResultSuccessProtocol {
    func successBlock() {
        print("Hey, I've got what you want :)")
    }
}

final class IJustWantDefaultError: ResultErrorDefaultProtocol {
    func defaultErrorBlock() {
        print("I'm a default error :)")
    }
}

final class IJustWantErrors: ResultErrorPersonNotFoundProtoco, ResultErrorEmailNotFoundProtocol {
    func personNotFoundBlock() {
        print("The person was not found :(")
    }
    
    func emailNotFoundBlock() {
        print("Person`s e-mail was not found :(")
    }
}

```

#### Dependency Inversion Principle (DIP)

It's basically that high classes and low classes should not depends to each other. They should depends from an abstraction. 

This way, your system could easily be changed by injecting diferents classes that implements the same protocol.

Here, we can also see the pattern dependency injection, which could be implemented by different ways.

```swift

protocol FormatterMaskProtocol {
    func mask(input: String) -> String
}

protocol FormatterProtocol {
    var formatter: FormatterMaskProtocol { get }
}

typealias FormatterChooserProtocol = FormatterMaskProtocol & FormatterProtocol

final class Formatter: FormatterChooserProtocol {
    var formatter: FormatterMaskProtocol
    
    func mask(input: String) -> String {
        return formatter.mask(input: input)
    }
}

final class FormatterNumber: FormatterMaskProtocol {
    func mask(input: String) -> String {
        var result = input
        if input.count == 8 {
            result.insert("-", at: result.index(result.startIndex, offsetBy: 4))
        }
        return result
    }
}

final class FormatterPhone: FormatterMaskProtocol {
    func mask(input: String) -> String {
        var result = input

        if input.count == 9 {
            result.insert("-", at: result.index(result.startIndex, offsetBy: 6))
        }
        
        return result
    }
}

```
