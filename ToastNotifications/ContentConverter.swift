//
//  ContentConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

typealias UIElements = (subviews: [UIView], constraints: [NSLayoutConstraint])

func convert(content: Content) -> UIView {
    let subContentOrigin = ContentPoint(x: 0, y: 0)
    let container = UIView()
    let (subViews, constraints) = convert(content: content,
                                          subContent: content,
                                          subContentOrigin: subContentOrigin,
                                          container: container)

    subViews.forEach {
        container.addSubview($0)
    }

    container.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(constraints)

    return container
}

/**
 Converts content to a collection of UI elements contained by the
 specified container view
 */
func convert(content: Content,
             subContent: Content,
             subContentOrigin: ContentPoint,
             container: UIView) -> UIElements {

    switch subContent {
    case .element(_, let element):
        let subview = convert(element: element)
        let constraints = subContentConstraints(content: content,
                                                 subContent: subContent,
                                                 subContentOrigin: subContentOrigin,
                                                 container: container,
                                                 subview: subview)
        return ([subview], constraints)

    case .beside(let leftContent, let rightContent):
        let leftContentOrigin = subContentOrigin
        let leftContentUIElements = convert(content: content,
                                            subContent: leftContent,
                                            subContentOrigin: leftContentOrigin,
                                            container: container)
        
        let rightContentOrigin = leftContentOrigin.offsetX(leftContent.size.width)
        let rightContentUIElements = convert(content: content,
                                             subContent: rightContent,
                                             subContentOrigin: rightContentOrigin,
                                             container: container)
        
        let UIElements = [leftContentUIElements, rightContentUIElements]
        let subviews = UIElements.flatMap { $0.subviews }
        let constraints = UIElements.flatMap { $0.constraints }
        return (subviews, constraints)
        
    case .stack(let topContent, let bottomContent):

        let topContentOrigin = subContentOrigin
        let topContentUIElements = convert(content: content,
                                           subContent: topContent,
                                           subContentOrigin: topContentOrigin,
                                           container: container)
        
        let bottomContentOrigin = topContentOrigin.offsetY(topContent.size.height)
        let bottomContentUIElements = convert(content: content,
                                              subContent: bottomContent,
                                              subContentOrigin: bottomContentOrigin,
                                              container: container)
        
        let UIElements = [topContentUIElements, bottomContentUIElements]
        let subviews = UIElements.flatMap { $0.subviews}
        let constraints = UIElements.flatMap { $0.constraints }
        return (subviews, constraints)
    }
}

func subContentConstraints(content: Content,
                           subContent: Content,
                           subContentOrigin: ContentPoint,
                           container: UIView,
                           subview: UIView) -> [NSLayoutConstraint] {

    subview.translatesAutoresizingMaskIntoConstraints = false

    let ratio = subContent.size / content.size
    let center = subContentOrigin + ratio

    let widthConstraint = NSLayoutConstraint(item: subview,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: container,
                                             attribute: .width,
                                             multiplier: CGFloat(ratio.width),
                                             constant: 0)

    let heightConstraint = NSLayoutConstraint(item: subview,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: container,
                                              attribute: .height,
                                              multiplier: CGFloat(ratio.height),
                                              constant: 0)

    let centerXConstraint = NSLayoutConstraint(item: subview,
                                               attribute: .centerX,
                                               relatedBy: .equal,
                                               toItem: container,
                                               attribute: .centerX,
                                               multiplier: center.x == 0 ? 1 : CGFloat(center.x),
                                               constant: 0)

    let centerYConstraint = NSLayoutConstraint(item: subview,
                                               attribute: .centerY,
                                               relatedBy: .equal,
                                               toItem: container,
                                               attribute: .centerY,
                                               multiplier: center.y == 0 ? 1 : CGFloat(center.y),
                                               constant: 0)
    return [widthConstraint,
            heightConstraint,
            centerXConstraint,
            centerYConstraint]
}
