//
//  Crypto.swift
//  Solid-sample
//
//  Created by Juan Munhoes Junior on 20/06/22.
//

protocol ICripto {
    var id: String { get }
    var name: String { get }
}

// I'm a crypto model
struct Crypto: ICripto {
    var id: String
    var name: String
}
