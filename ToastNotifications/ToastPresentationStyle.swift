//
//  ToastStyle.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/4/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

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
        let originY = screenSize.height * 0.45
        return CGPoint(x: originX, y: originY)
    }

    var frame: CGRect {
        return CGRect(origin: origin, size: size)
    }

    var center: CGPoint {
        // TODO: Add a convenience function to get the centr of a rectangle
        let screenSize = UIScreen.mainScreen().bounds
        let centerX = CGRectGetMidX(screenSize)
        let centerY = CGRectGetMidY(screenSize)
        return CGPoint(x: centerX, y: centerY)
    }

    var backgroundColor: UIColor {
        return UIColor.blueColor()
    }
}