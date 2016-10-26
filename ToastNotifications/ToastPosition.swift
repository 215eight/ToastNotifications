//
//  ToastPosition.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

enum ToastPosition {
    case top
    case bottom
    case center

    func positionConfigurator() -> (UIView) -> Void {

        return { (view) in
            guard let superView = view.superview else {
                assertionFailure("View must be part of the view hierarchy")
                return
            }

            let centerX = NSLayoutConstraint(item: view,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: superView,
                                             attribute: .centerX,
                                             multiplier: 1.0,
                                             constant: 0)


            let multiplier: CGFloat

            switch self {
            case .top:
                multiplier = -0.5
            case .center:
                multiplier = 1.0
            case .bottom:
                multiplier = 1.5
            }

            let centerY = NSLayoutConstraint(item: view,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: superView,
                                             attribute: .centerY,
                                             multiplier: multiplier,
                                             constant: 0)

            NSLayoutConstraint.activate([centerX, centerY])

        }
    }
}
