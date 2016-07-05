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

    func styleConfiguration() -> (UIView) -> Void {
        switch self {
        case .Plain:
            return { (view) in
                guard let superview = view.superview else {
                    assertionFailure("Can't apply style to a view that is not in the view hierarchy")
                    return
                }

                view.translatesAutoresizingMaskIntoConstraints = false

                let widthConstraint = NSLayoutConstraint(item: view,
                                                         attribute: .Width,
                                                         relatedBy: .Equal,
                                                         toItem: superview,
                                                         attribute: .Width,
                                                         multiplier: 1,
                                                         constant: 0)

                let heightConstraint = NSLayoutConstraint(item: view,
                                                          attribute: .Height,
                                                          relatedBy: .Equal,
                                                          toItem: superview,
                                                          attribute: .Height,
                                                          multiplier: 0.1,
                                                          constant: 0)

                let centerXConstraint = NSLayoutConstraint(item: view,
                                                           attribute: .CenterX,
                                                           relatedBy: .Equal,
                                                           toItem: superview,
                                                           attribute: .CenterX,
                                                           multiplier: 1,
                                                           constant: 0)

                let centerYConstraint = NSLayoutConstraint(item: view,
                                                           attribute: .CenterY,
                                                           relatedBy: .Equal,
                                                           toItem: superview,
                                                           attribute: .CenterY,
                                                           multiplier: 1,
                                                           constant: 0)

                let constraints = [widthConstraint,
                                   heightConstraint,
                                   centerXConstraint,
                                   centerYConstraint]

                NSLayoutConstraint.activateConstraints(constraints)
            }
        case .RoundedRect:
            return { (view) in
                view.layer.cornerRadius = 10
                view.clipsToBounds = true
                view.backgroundColor = UIColor.orangeColor()
            }
        }
    }
    
}
