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
}