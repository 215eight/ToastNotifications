//
//  ToastSize.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

enum ToastSize {
    case absolute(width: CGFloat, height: CGFloat)
    case relative(xRatio: CGFloat, yRatio: CGFloat)

    func sizeConfigurator() -> (UIView) -> Void {
        return { (view) in
            guard let superView = view.superview else {
                assertionFailure("View must be part of the view hierarchy")
                return
            }


            let constraints: [NSLayoutConstraint]
            switch self {
            case .absolute(let width, let height):
                constraints = self.absoluteConstraints(view: view,
                                                       width: width,
                                                       height: height)
            case .relative(let xRatio, let yRatio):
                constraints = self.relativeConstraints(view: view,
                                                       superView: superView,
                                                       xRatio: xRatio,
                                                       yRatio: yRatio)
            }

            NSLayoutConstraint.activate(constraints)
        }
    }
}

private extension ToastSize {

    func absoluteConstraints(view: UIView,
                                  width: CGFloat,
                                  height: CGFloat) -> [NSLayoutConstraint] {
        let width = NSLayoutConstraint(item: view,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 0,
                                       constant: width)

        let height = NSLayoutConstraint(item: view,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: height)
        return [width, height]
    }

    func relativeConstraints(view: UIView,
                                  superView: UIView,
                                  xRatio: CGFloat,
                                  yRatio: CGFloat) -> [NSLayoutConstraint] {
        let width = NSLayoutConstraint(item: view,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: superView,
                                       attribute: .width,
                                       multiplier: xRatio,
                                       constant: 0)

        let height = NSLayoutConstraint(item: view,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: superView,
                                        attribute: .height,
                                        multiplier: yRatio,
                                        constant: 0)
        return [width, height]
    }
}
