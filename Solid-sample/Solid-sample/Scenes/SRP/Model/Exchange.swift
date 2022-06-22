//
//  Exchange.swift
//  Solid-sample
//
//  Created by Juan Munhoes Junior on 20/06/22.
//

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
