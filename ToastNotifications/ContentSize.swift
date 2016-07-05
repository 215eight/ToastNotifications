//
//  ContentSize.swift
//  ToastNotifications
//
//  Created by pman215 on 6/5/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

struct ContentSize {
    let width: Double
    let height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension ContentSize: Equatable { }

func == (lhs: ContentSize, rhs: ContentSize) -> Bool {
    return lhs.height == rhs.height && lhs.width == rhs.width
}

func / (lhs: ContentSize, rhs: ContentSize) -> ContentSize {
    let width = lhs.width / rhs.width
    let height = lhs.height / rhs.height
    return ContentSize(width: width, height: height)
}

func + (lhs: ContentPoint, rhs: ContentSize) -> ContentPoint {
    return ContentPoint(x: lhs.x + rhs.width,
                        y: lhs.y + rhs.height)
}
