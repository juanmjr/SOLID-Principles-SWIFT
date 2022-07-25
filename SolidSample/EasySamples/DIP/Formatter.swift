//
//  Formatter.swift
//  SolidSample
//
//  Created by Juan Munhoes Junior on 22/06/22.
//

protocol IFormatterMask {
    func mask(input: String) -> String
}

protocol IFormatter {
    var formatter: IFormatterMask { get }
}

typealias IFormatterChooser = IFormatterMask & IFormatter

struct Formatter: IFormatterChooser {
    var formatter: IFormatterMask
    
    func mask(input: String) -> String {
        return formatter.mask(input: input)
    }
}

struct FormatterNumber: IFormatterMask {
    func mask(input: String) -> String {
        var result = input
        if input.count == 8 {
            result.insert("-", at: result.index(result.startIndex, offsetBy: 4))
        }
        return result
    }
}

struct FormatterPhone: IFormatterMask {
    func mask(input: String) -> String {
        var result = input

        if input.count == 9 {
            result.insert("-", at: result.index(result.startIndex, offsetBy: 6))
        }
        
        return result
    }
}
