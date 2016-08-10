//
//  ToastPosition.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

enum ToastPosition {
    case Top
    case Bottom
    case Center

    func positionConfigurator() -> (UIView) -> Void {

        return { (view) in
            guard let superView = view.superview else {
                assertionFailure("View must be part of the view hierarchy")
                return
            }

            let centerX = NSLayoutConstraint(item: view,
                                             attribute: .CenterX,
                                             relatedBy: .Equal,
                                             toItem: superView,
                                             attribute: .CenterX,
                                             multiplier: 1.0,
                                             constant: 0)


            let multiplier: CGFloat

            switch self {
            case .Top:
                multiplier = -0.5
            case .Center:
                multiplier = 1.0
            case .Bottom:
                multiplier = 1.5
            }

            let centerY = NSLayoutConstraint(item: view,
                                             attribute: .CenterY,
                                             relatedBy: .Equal,
                                             toItem: superView,
                                             attribute: .CenterY,
                                             multiplier: multiplier,
                                             constant: 0)

            NSLayoutConstraint.activateConstraints([centerX, centerY])

        }
    }
}
