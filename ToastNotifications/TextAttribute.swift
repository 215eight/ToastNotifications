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

extension TextAttribute: Equatable { }

func == (lhs: TextAttribute, rhs: TextAttribute) -> Bool {

    switch (lhs, rhs) {
    case (.Font(let lhsFont), .Font(let rhsFont)):
        return lhsFont == rhsFont
    case (.Alignment(let lhsAlignment), .Alignment(let rhsAlignment)):
        return lhsAlignment == rhsAlignment
    case (.ForegroundColor(let lhsColor), .ForegroundColor(let rhsColor)):
        return lhsColor == rhsColor
    case (.BackgroundColor(let lhsColor), .BackgroundColor(let rhsColor)):
        return lhsColor == rhsColor
    case (.Compose(let lhsAttrribute), .Compose(let rhsAttribute)):
        return lhsAttrribute == rhsAttribute
    case (.Font(_), _),
         (.Alignment(_), _),
         (.ForegroundColor(_), _),
         (.BackgroundColor(_), _),
         (.Compose(_, _), _):
        return false
    }
}
