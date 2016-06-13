//
//  ToastContentConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 Converts the toast content to a collection of UI elements contained by the
 specified frame
 */
func convert(toastContent: ToastContent, frame: CGRect) -> [UIView] {

    var views = [UIView]()

    switch toastContent {

    case .Element(let size, let element):
        let frame = size.fit(frame)
        let view = convert(element, frame: frame)
        views.append(view)

    case .Beside(let lhs, let rhs):
        let widthRatio = CGFloat((lhs.size / toastContent.size).width)
        let (leftRect, rightRect) = frame.split(widthRatio, edge: .MinXEdge)
        views.appendContentsOf( [(lhs, leftRect), (rhs, rightRect)]
                                .flatMap { convert($0.0, frame: $0.1) } )

    case .Stack(let lhs, let rhs):
        let heightRatio = CGFloat((lhs.size / toastContent.size).height)
        let (topRect, bottomRect) = frame.split(heightRatio, edge: .MinYEdge)
        views.appendContentsOf( [(lhs, topRect), (rhs, bottomRect)]
                                .flatMap { convert($0.0, frame: $0.1) } )
    }

    return views
}