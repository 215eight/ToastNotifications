//
//  ToastSize.swift
//  ToastNotifications
//
//  Created by pman215 on 6/5/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

struct ToastSize {
    let width: Double
    let height: Double

    init() {
        self.width = 0
        self.height = 0
    }

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension ToastSize: Equatable { }

func == (lhs: ToastSize, rhs: ToastSize) -> Bool {
    return lhs.height == rhs.height && lhs.width == rhs.width
}

extension ToastSize {

    func fit(rect: CGRect) -> CGRect {
        let scaleSize = rect.size / self
        let scale = min(scaleSize.width, scaleSize.height)
        let size = scale * self
        return CGRect(origin: rect.origin, size: size)
    }
}

func / (lhs: ToastSize, rhs: ToastSize) -> ToastSize {
    let width = lhs.width / rhs.width
    let height = lhs.height / rhs.height
    return ToastSize(width: width, height: height)
}

func / (lhs: CGSize, rhs: ToastSize) -> CGSize {
    let width = lhs.width / CGFloat(rhs.width)
    let height = lhs.height / CGFloat(rhs.height)
    return CGSize(width: width, height: height)
}

func / (lhs: ToastSize, rhs: CGSize) -> CGSize {
    let width = CGFloat(lhs.width) / rhs.width
    let height = CGFloat(lhs.height) / rhs.height
    return CGSize(width: width, height: height)
}

func * (lhs: CGFloat, rhs: ToastSize) -> CGSize {
    let width = CGFloat(rhs.width) * lhs
    let height = CGFloat(rhs.height) * lhs
    return CGSize(width: width, height: height)
}