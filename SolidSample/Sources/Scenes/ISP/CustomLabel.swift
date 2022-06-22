//
//  CustomLabel.swift
//  SolidSample
//
//  Created by Juan Munhoes Junior on 22/06/22.
//

import Foundation
import UIKit

protocol IImageLabel {
    func addImage(image: UIImage)
}

enum MaskType {
    case phone, number
}

protocol IMaskedLabel {
    func mask(type: MaskType)
}

protocol ILabel {
    var label: UILabel { get }
}

struct CustomImageLabel: IImageLabel, ILabel {
    var label: UILabel

    func addImage(image: UIImage) {
        
    }
}

struct CustomMaskedLabel: IMaskedLabel, ILabel {
    var label: UILabel

    func mask(type: MaskType) {
        let masked = Formatter(formatter: type == .phone ? FormatterPhone() : FormatterNumber())
        label.text = masked.execute(input: label.text ?? "")
    }
}

struct CustomImageMaskedLabel: IImageLabel, IMaskedLabel, ILabel {
    var label: UILabel

    func addImage(image: UIImage) {
        
    }
    
    func mask(type: MaskType) {
        let masked = Formatter(formatter: type == .phone ? FormatterPhone() : FormatterNumber())
        label.text = masked.execute(input: label.text ?? "")
    }
}
