//
//  Network.swift
//  Solid-sample
//
//  Created by Juan Munhoes Junior on 21/06/22.
//

struct NetworkLog: IPrinter {
    var logger: String

    func print() -> String {
        return "I'm a Networking Log - " + logger
    }
}
