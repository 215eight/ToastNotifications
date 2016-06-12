//
//  CGRectExtensions.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/5/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {

    func split(ratio: CGFloat, edge: CGRectEdge) -> (CGRect, CGRect) {

        switch edge {
        case .MaxXEdge, .MinXEdge:
            let length = width
            return divide(length * ratio, fromEdge: .MinXEdge)
        case .MaxYEdge, .MinYEdge:
            let length = height
            return divide(length * ratio, fromEdge: .MinYEdge)
        }
    }
}
