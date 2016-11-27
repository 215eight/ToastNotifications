//
//  NSLayoutConstraintExtension.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 7/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    func present(in constraints: [NSLayoutConstraint]) -> Bool {
        for constraint in constraints {
            if self == constraint {
                return true
            }
        }
        return false
    }
}
func ==(lhs: NSLayoutConstraint, rhs: NSLayoutConstraint) -> Bool {
    return lhs.firstItem === rhs.firstItem &&
        lhs.firstAttribute == rhs.firstAttribute &&
        lhs.relation == rhs.relation &&
        lhs.secondItem === rhs.secondItem &&
        lhs.secondAttribute == rhs.secondAttribute &&
        lhs.multiplier == rhs.multiplier &&
        lhs.constant == rhs.constant &&
        lhs.priority == rhs.priority
}
