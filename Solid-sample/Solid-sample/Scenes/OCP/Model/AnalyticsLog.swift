//
//  Analytics.swift
//  Solid-sample
//
//  Created by Juan Munhoes Junior on 21/06/22.
//

struct AnalyticsLog: IPrinter {
    var logger: String
    
    func print() -> String {
        return "I'm an Analytics Log - " + logger
    }
}
