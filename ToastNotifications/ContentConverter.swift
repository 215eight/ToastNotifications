//
//  ContentConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

typealias ToastUIElements = ([UIView], [NSLayoutConstraint])

/**
 Converts content to a collection of UI elements contained by the
 specified container view
 */
func convert(toastContent: Content, container: UIView) -> ToastUIElements {
    let subContentOrigin = ContentPoint(x: 0, y: 0)
    return contentUIElements(content: toastContent,
                             subContent: toastContent,
                             subContentOrigin: subContentOrigin,
                             container: container)
}

func contentUIElements(content content: Content,
                      subContent: Content,
                      subContentOrigin: ContentPoint,
                      container: UIView) -> ToastUIElements {

    switch subContent {

    case .Element(_, let element):
        let subview = convert(element)
        let constraints = subContentConstraints(content: content,
                                                 subContent: subContent,
                                                 subContentOrigin: subContentOrigin,
                                                 container: container,
                                                 subview: subview)
        return ([subview], constraints)

    case .Beside(let leftContent, let rightContent):

        let leftContentOrigin = subContentOrigin
        let leftContentUIElements = contentUIElements(content: content,
                                                      subContent: leftContent,
                                                      subContentOrigin: leftContentOrigin,
                                                      container: container)
        
        let rightContentOrigin = leftContentOrigin.offsetX(leftContent.size.width)
        let rightContentUIElements = contentUIElements(content: content,
                                                       subContent: rightContent,
                                                       subContentOrigin: rightContentOrigin,
                                                       container: container)
        
        let UIElements = [leftContentUIElements, rightContentUIElements]
        let subviews = UIElements.flatMap { $0.0 }
        let constraints = UIElements.flatMap { $0.1 }
        
        return (subviews, constraints)
        
    case .Stack(let topContent, let bottomContent):

        let topContentOrigin = subContentOrigin
        let topContentUIElements = contentUIElements(content: content,
                                                     subContent: topContent,
                                                     subContentOrigin: topContentOrigin,
                                                     container: container)
        
        let bottomContentOrigin = topContentOrigin.offsetY(topContent.size.height)
        let bottomContentUIElements = contentUIElements(content: content,
                                                        subContent: bottomContent,
                                                        subContentOrigin: bottomContentOrigin,
                                                        container: container)
        
        let UIElements = [topContentUIElements, bottomContentUIElements]
        let subviews = UIElements.flatMap { $0.0 }
        let constraints = UIElements.flatMap { $0.1 }

        return (subviews, constraints)
    }
}

func subContentConstraints(content content: Content,
                           subContent: Content,
                           subContentOrigin: ContentPoint,
                           container: UIView,
                           subview: UIView) -> [NSLayoutConstraint] {

    subview.translatesAutoresizingMaskIntoConstraints = false

    let ratio = subContent.size / content.size
    let center = subContentOrigin + ratio

    let widthConstraint = NSLayoutConstraint(item: subview,
                                             attribute: .Width,
                                             relatedBy: .Equal,
                                             toItem: container,
                                             attribute: .Width,
                                             multiplier: CGFloat(ratio.width),
                                             constant: 0)

    let heightConstraint = NSLayoutConstraint(item: subview,
                                              attribute: .Height,
                                              relatedBy: .Equal,
                                              toItem: container,
                                              attribute: .Height,
                                              multiplier: CGFloat(ratio.height),
                                              constant: 0)

    let centerXConstraint = NSLayoutConstraint(item: subview,
                                               attribute: .CenterX,
                                               relatedBy: .Equal,
                                               toItem: container,
                                               attribute: .CenterX,
                                               multiplier: center.x == 0 ? 1 : CGFloat(center.x),
                                               constant: 0)

    let centerYConstraint = NSLayoutConstraint(item: subview,
                                               attribute: .CenterY,
                                               relatedBy: .Equal,
                                               toItem: container,
                                               attribute: .CenterY,
                                               multiplier: center.y == 0 ? 1 : CGFloat(center.y),
                                               constant: 0)
    return [widthConstraint,
            heightConstraint,
            centerXConstraint,
            centerYConstraint]
}
