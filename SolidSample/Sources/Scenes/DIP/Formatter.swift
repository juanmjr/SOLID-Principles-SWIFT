//
//  Formatter.swift
//  SolidSample
//
//  Created by Juan Munhoes Junior on 22/06/22.
//

protocol IFormatterMask {
    func format(input: String) -> String
}

protocol IFormatter {
    var formatter: IFormatterMask { get }
    func execute(input: String) -> String
}

struct Formatter: IFormatter {
    var formatter: IFormatterMask
    
    func execute(input: String) -> String {
        return formatter.format(input: input)
    }
}

struct FormatterNumber: IFormatterMask {
    func format(input: String) -> String {
        var result = input
        if input.count == 8 {
            result.insert("-", at: result.index(result.startIndex, offsetBy: 4))
        }
        return result
    }
}

struct FormatterPhone: IFormatterMask {
    func format(input: String) -> String {
        var result = input

        if input.count == 9 {
            result.insert("-", at: result.index(result.startIndex, offsetBy: 6))
        }
        
        return result
    }
}
