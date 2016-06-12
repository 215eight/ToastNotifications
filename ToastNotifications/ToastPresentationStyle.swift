//
//  ToastStyle.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/4/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

/**
 Lists the available toast presentation styles

 + Center: The view will show in the center of the screen

 */
enum ToastPresentationStyle {
    case Plain

    var size: CGSize {
        let screenSize = UIScreen.mainScreen().bounds.size
        let width = screenSize.width * 0.9
        let height = screenSize.height * 0.1
        return CGSize(width: width, height: height)
    }

    var origin: CGPoint {
        let screenSize = UIScreen.mainScreen().bounds.size
        let originX = screenSize.width * 0.05
        let originY = screenSize.height * 0.75
        return CGPoint(x: originX, y: originY)
    }

    var frame: CGRect {
        return CGRect(origin: origin, size: size)
    }
}
