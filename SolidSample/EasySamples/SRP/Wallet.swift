//
//  Wallet.swift
//  Solid-sample
//
//  Created by Juan Munhoes Junior on 20/06/22.
//

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
