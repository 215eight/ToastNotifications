//
//  ToastStyle.swift
//  ToastNotifications
//
//  Created by pman215 on 6/4/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 Lists the available toast presentation styles

 + Center: The view will show in the center of the screen

 */
enum ToastPresentationStyle {
    case Plain
    case RoundedRect

    func widthRatio(view: UIView) -> CGFloat {
        switch self {
        case .Plain:
            return 1
        case .RoundedRect:
            return 0.9
        }
    }

    func heightRatio(view: UIView) -> CGFloat {
        switch self {
        case .Plain:
            return 1
        case .RoundedRect:
            return 0.1
        }
    }

    func cneterXRatio(view: UIView) -> CGFloat {
        switch self {
        case .Plain:
            return 1
        case .RoundedRect:
            return 1
        }
    }
    func centerYRatio(view: UIView) -> CGFloat {
        switch self {
        case .Plain:
            return 1
        case .RoundedRect:
            return 1
        }
    }

    func styleConfiguration() -> (UIView) -> Void {
        switch self {
        case .Plain:
            return { (_) in }
        case .RoundedRect:
            return { (view) in
                view.layer.cornerRadius = 10
                view.clipsToBounds = true
                view.backgroundColor = UIColor.orangeColor()
            }
        }
    }
    
}
