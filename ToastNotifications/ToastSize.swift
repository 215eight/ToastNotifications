//
//  ToastSize.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

enum ToastSize {
    case Absolute(width: CGFloat, height: CGFloat)
    case Relative(xRatio: CGFloat, yRatio: CGFloat)

    func sizeConfigurator() -> (UIView) -> Void {
        return { (view) in
            guard let superView = view.superview else {
                assertionFailure("View must be part of the view hierarchy")
                return
            }


            let constraints: [NSLayoutConstraint]
            switch self {
            case .Absolute(let width, let height):
                constraints = self.absoluteConstraints(view: view,
                                                       width: width,
                                                       height: height)
            case .Relative(let xRatio, let yRatio):
                constraints = self.relativeConstraints(view: view,
                                                       superView: superView,
                                                       xRatio: xRatio,
                                                       yRatio: yRatio)
            }

            NSLayoutConstraint.activateConstraints(constraints)
        }
    }
}

private extension ToastSize {

    func absoluteConstraints(view view: UIView,
                                  width: CGFloat,
                                  height: CGFloat) -> [NSLayoutConstraint] {
        let width = NSLayoutConstraint(item: view,
                                       attribute: .Width,
                                       relatedBy: .Equal,
                                       toItem: nil,
                                       attribute: .NotAnAttribute,
                                       multiplier: 0,
                                       constant: width)

        let height = NSLayoutConstraint(item: view,
                                        attribute: .Height,
                                        relatedBy: .Equal,
                                        toItem: nil,
                                        attribute: .NotAnAttribute,
                                        multiplier: 0,
                                        constant: height)
        return [width, height]
    }

    func relativeConstraints(view view: UIView,
                                  superView: UIView,
                                  xRatio: CGFloat,
                                  yRatio: CGFloat) -> [NSLayoutConstraint] {
        let width = NSLayoutConstraint(item: view,
                                       attribute: .Width,
                                       relatedBy: .Equal,
                                       toItem: superView,
                                       attribute: .Width,
                                       multiplier: xRatio,
                                       constant: 0)

        let height = NSLayoutConstraint(item: view,
                                        attribute: .Height,
                                        relatedBy: .Equal,
                                        toItem: superView,
                                        attribute: .Height,
                                        multiplier: yRatio,
                                        constant: 0)
        return [width, height]
    }
}
