//
//  TextAttribute.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 List attributes for a text toast element
 */
indirect enum TextAttribute {
    case Font(UIFont)
    case Alignment(NSTextAlignment)
    case ForegroundColor(UIColor)
    case BackgroundColor(UIColor)
    case Compose(TextAttribute, TextAttribute)

    init(fontName: String, size: CGFloat) {

        let font: UIFont

        if let _font = UIFont(name: fontName, size: size) {
            font = _font
        } else {
            font = UIFont.systemFontOfSize(size)
        }

        self = .Font(font)
    }

    init(alignment: NSTextAlignment) {
        self = .Alignment(alignment)
    }

    init(color: UIColor) {
        self = .ForegroundColor(color)
    }

    init(backgroundColor: UIColor) {
        self = .BackgroundColor(backgroundColor)
    }

    func map(@noescape f: () -> TextAttribute) -> TextAttribute {
        return .Compose(self, f())
    }

    init() {
       self = TextAttribute.Font(UIFont.systemFontOfSize(16))
                           .map { .Alignment(.Center) }
                           .map { .ForegroundColor(UIColor.blackColor()) }
                           .map { .BackgroundColor(UIColor.clearColor()) }
    }
}