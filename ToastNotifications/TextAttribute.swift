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
 List attributes for a text element
 */

indirect enum TextAttribute {
    case font(UIFont)
    case alignment(NSTextAlignment)
    case foregroundColor(UIColor)
    case backgroundColor(UIColor)
    case compose(TextAttribute, TextAttribute)

    func map(_ f: @autoclosure () -> TextAttribute) -> TextAttribute {
        return .compose(self, f())
    }

    init() {
       self = TextAttribute.font(UIFont.systemFont(ofSize: 16))
                           .map ( .alignment(.center) )
                           .map ( .foregroundColor(UIColor.black) )
                           .map ( .backgroundColor(UIColor.clear) )
    }
}

extension TextAttribute: Equatable { }

func == (lhs: TextAttribute, rhs: TextAttribute) -> Bool {

    switch (lhs, rhs) {

    case (.font(let lhsFont), .font(let rhsFont)):
        return lhsFont == rhsFont

    case (.alignment(let lhsAlignment), .alignment(let rhsAlignment)):
        return lhsAlignment == rhsAlignment

    case (.foregroundColor(let lhsColor), .foregroundColor(let rhsColor)):
        return lhsColor == rhsColor

    case (.backgroundColor(let lhsColor), .backgroundColor(let rhsColor)):
        return lhsColor == rhsColor

    case (.compose(let lhsAttrribute), .compose(let rhsAttribute)):
        return lhsAttrribute == rhsAttribute

    case (.font(_), _),
         (.alignment(_), _),
         (.foregroundColor(_), _),
         (.backgroundColor(_), _),
         (.compose(_, _), _):
        return false
    }
}
