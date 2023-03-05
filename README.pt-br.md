[![how-to](https://img.shields.io/badge/how--to-use-blue.svg)](https://github.com/yonaskolb/XcodeGen)

Instale o xcodegen para gerar o arquivo .xcodeproj para rodar o projeto exemplo.

Rode o comando 'xcodegen' no terminal na pasta raiz do projeto exemplo (onde está o arquivo .yml).

# Linguagens disponíveis
[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/juanmjr/SOLID-Principles-SWIFT/blob/main/README.md)
[![pt-br](https://img.shields.io/badge/lang-en-green.svg)](https://github.com/juanmjr/SOLID-Principles-SWIFT/blob/main/README.pt-br.md)

# S.O.L.I.D. 

<p align="center">
  <img src="https://github.com/juanmjr/SOLID-Principles-SWIFT/blob/feature/solid-image/solid.png" />
</p>

<p align="center">
   Os princípios do acrônimo OOD (design orientado a objetos) por Robert C. Martin
</p>

<br/>

As letras SOLID fazem parte de cinco princípios, o que coloca seu código em um nível alto.

Deve ser praticado e utilizado por engenheiros especializados em qualquer tipo de aplicação.

Os sistemas apresentam um bom código limpo e tornam uma maneira fácil de mudar e construir através de compensações para suas respectivas arquiteturas.

#### Princípio da Responsabilidade Única (SRP)

Diz que uma classe deve ter UM motivo para fazer algo. Por isso, você deve pensar em abstrair responsabilidades entre as classes do seu sistema.

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

// Eu sou uma bolsa e só faço operações de compra/venda em uma lista de carteira
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

// Sou carteira e só sei administrar uma lista de criptomoedas.
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

// Eu sou um modelo de criptomoeda
final class Crypto: CryptoProtocol {
    var id: String
    var name: String
}

```

#### Princípio do Aberto e Fechado (OCP) 

Ele diz que você não deve modificar sua classe dentro. Você deve criar extensões e alterá-las por fora.

Não significa extensão em Swift! É criar outra abstração e implementação para o seu problema sem quebrar a solução, usando boas práticas da sigla POP (programação orientada a protocolo).

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

Ele diz que todas as partes da herança de classe do pai por subclasses devem ser usadas e não podem quebrá-las.

Um exemplo simples e fácil é que uma classe DOG herda uma classe CAT, apenas porque ambos andam ou algo assim. Ele traz funções inúteis para a subclasse e os comportamentos são totalmente diferentes, o que pode apresentar falha no sistema.
 
Como conclusão fato, o Princípio de Liskov nos dá um alerta! Não use uma herança simplesmente porque parece legal ou você acha que reutiliza apenas algumas funções. Além disso, fique fascinado com o uso de protocolos e uma boa abstração do que heranças.

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

Não crie interfaces longas ou mesmo funções que não seriam utilizadas na classe de implementação.

Segregação significa dividir suas interfaces em pequenas seções de abstração. Segui-lo seria a maneira mais fácil de conquistar esse princípio :)

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

É basicamente que classes altas e classes baixas não devem depender umas das outras. Eles devem depende de uma abstração.

Dessa forma, seu sistema pode ser facilmente alterado injetando diferentes classes que implementam o mesmo protocolo.

Aqui, também podemos ver a injeção de dependência padrão, que pode ser implementada de diferentes maneiras.

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
