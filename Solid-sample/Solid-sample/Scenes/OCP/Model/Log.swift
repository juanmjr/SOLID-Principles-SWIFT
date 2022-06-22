//
//  Log.swift
//  Solid-sample
//
//  Created by Juan Munhoes Junior on 21/06/22.
//

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
