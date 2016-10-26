//
//  TextAttributeConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 Dictionary with attribute keys and its associated attribute objects
 */
typealias UITextAttribute = [String : AnyObject]

/**
 Converts a `Text Attribute` to a `UITextAttribute`
 */
func convert(attribute: TextAttribute) -> UITextAttribute {

    return convert(attribute, attributes: UITextAttribute())
}

private func convert(_ attribute: TextAttribute, attributes: UITextAttribute) -> UITextAttribute {


    var newAttributes = attributes

    switch attribute {
    case .font(let font):
        newAttributes[NSFontAttributeName] = font

    case .alignment(let alignment):
        let paragraphAlignment = NSMutableParagraphStyle()
        paragraphAlignment.alignment = alignment
        newAttributes[NSParagraphStyleAttributeName]  = paragraphAlignment

    case .foregroundColor(let color):
        newAttributes[NSForegroundColorAttributeName] = color

    case .backgroundColor(let color):
        newAttributes[NSBackgroundColorAttributeName] = color

    case .compose(let lhs, let rhs):
        let lhsAttributes = convert(lhs, attributes: newAttributes)
        let rhsAttributes = convert(rhs, attributes: lhsAttributes)
        newAttributes = rhsAttributes
    }

    return newAttributes
}
