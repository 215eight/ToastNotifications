//
//  NSLayouConstraintExtension.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 7/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    override public func isEqual(object: AnyObject?) -> Bool {

        guard let otherConstraint = object as? NSLayoutConstraint else {
            return false
        }

        return self.firstItem === otherConstraint.firstItem &&
            self.firstAttribute == otherConstraint.firstAttribute &&
            self.relation == self.relation &&
            self.secondItem === otherConstraint.secondItem &&
            self.secondAttribute == otherConstraint.secondAttribute &&
            self.multiplier == otherConstraint.multiplier &&
            self.constant == otherConstraint.constant &&
            self.priority == otherConstraint.priority
    }
}
