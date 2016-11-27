//
//  ToastPosition.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

enum ToastPosition {
    case top(offset: CGFloat)
    case bottom(offset: CGFloat)
    case center

    func addPositionConstraints(to view: UIView) {

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

        let centerY: NSLayoutConstraint

        switch self {
        case .top:
            centerY = topConstraint(view: view)

        case .center:
            centerY = centerConstraint(view: view)

        case .bottom:
            centerY = bottomConstraint(view: view)

        }

        NSLayoutConstraint.activate([centerX, centerY])
    }
}

private extension ToastPosition {

    var offset: CGFloat {
        switch self  {
        case let .top(offset):
            return offset

        case let .bottom(offset):
            return offset

        case .center:
            return 0
        }
    }

    func topConstraint(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .top,
                                  relatedBy: .equal,
                                  toItem: view.superview!,
                                  attribute: .top,
                                  multiplier: 1,
                                  constant: offset)
    }

    func centerConstraint(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .centerY,
                                  relatedBy: .equal,
                                  toItem: view.superview!,
                                  attribute: .centerY,
                                  multiplier: 1,
                                  constant: offset)
    }

    func bottomConstraint(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: view.superview!,
                                  attribute: .bottom,
                                  multiplier: 1,
                                  constant: -offset)
    }
}
