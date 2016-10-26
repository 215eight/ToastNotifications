//
//  ContentPoint.swift
//  ToastNotifications
//
//  Created by pman215 on 7/4/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

internal struct ContentPoint {
    let x: Double
    let y: Double

    func offsetX(_ offset: Double) -> ContentPoint {
        return ContentPoint(x: x + offset,
                            y: y)
    }

    func offsetY(_ offset: Double) -> ContentPoint {
        return ContentPoint(x: x,
                            y: y + offset)
    }
}
