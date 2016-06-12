//
//  ToastContent.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

// MARK: ToastElement

enum Attribute {
    case Font(UIFont)
    case Alignment(NSTextAlignment)
    case ForegroundColor(UIColor)
    case BackgroundColor(UIColor)
}

/**
 List the available toast elements

 + Text: Adds the text for that element
 + Image: Adds the image with specified named for that element
 */

indirect enum ToastElement {
    case Text(String)
    case Image(String)
}

extension ToastElement: Equatable { }

func ==(lhs: ToastElement, rhs: ToastElement) -> Bool {
    switch (lhs, rhs) {
    case (.Text(let lhsText), .Text(let rhsText)):
        return lhsText == rhsText
    case (.Image(let lhsName), .Image(let rhsName)):
        return lhsName == rhsName
    default:
        return false
    }
}


/**
 Models the content of a toast

 + Element: A toast element and its size relative to other elements that are
 part of the same content

 + Beside: Two content elements side by side

 + Stack: Two content element stacked against each other
 */
indirect enum ToastContent {

    case Element(ToastSize, ToastElement)
    case Beside(ToastContent, ToastContent)
    case Stack(ToastContent, ToastContent)

    init() {

        self = .Element(ToastSize(), .Text(""))
    }

    /**
     Creates a toast content with a single text element of size 1x1
     */
    init(text: String) {

        let size = ToastSize(width: 1, height: 1)
        self = .Element(size, .Text(text))
    }

    /**
     Creates a toast content with a single image element of size 1x1
     */
    init(imageName: String) {

        let size = ToastSize(width: 1, height: 1)
        self = .Element(size, .Image(imageName))
    }

    var size: ToastSize {

        switch self {

        case .Element(let size, _):
            return size

        case .Beside(let lhs, let rhs):
            let width = lhs.size.width + rhs.size.width
            let height = max(lhs.size.height, rhs.size.height)
            let size = ToastSize(width: width, height: height)
            return size

        case .Stack(let lhs, let rhs):
            let width = max(lhs.size.width, rhs.size.width)
            let height = lhs.size.height + rhs.size.height
            let size = ToastSize(width: width, height: height)
            return size
        }
    }
}

extension ToastContent: Equatable { }

func ==(lhs: ToastContent, rhs: ToastContent) -> Bool {

    switch (lhs, rhs) {

    case (.Element(let lhsSize, let lhsElement), .Element(let rhsSize, let rhsElement)):
        return lhsSize == rhsSize && lhsElement == rhsElement

    case (.Beside(let lhsLeft, let lhsRight), .Beside(let rhsLeft, let rhsRight)):
        return lhsLeft == rhsLeft && lhsRight == rhsRight

    default:
        return false
    }
}

infix operator ||| { associativity left }

func |||(lhs: ToastContent, rhs: ToastContent) -> ToastContent {

    return ToastContent.Beside(lhs, rhs)
}

infix operator --- { associativity left }

func ---(top: ToastContent, bottom: ToastContent) -> ToastContent {

    return ToastContent.Stack(top, bottom)
}

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
        views.appendContentsOf( [(leftRect, lhs), (rightRect, rhs)]
                                .flatMap { convert($0.1, frame: $0.0) } )

    case .Stack(let lhs, let rhs):
        let heightRatio = CGFloat((lhs.size / toastContent.size).height)
        let (topRect, bottomRect) = frame.split(heightRatio, edge: .MinYEdge)
        views.appendContentsOf( [(topRect, lhs), (bottomRect, rhs)]
                                .flatMap { convert($0.1, frame: $0.0) } )
    }

    return views
}

/**
 Converts a toast element to a UI element with the specified frame
 */
func convert(element: ToastElement, frame: CGRect) -> UIView {

    switch element {

    case .Text(let text):
        let label = UILabel(frame: frame)
        label.text = text
        return label

    case .Image(let name):
        let image = UIImage.nonNullImage(name)
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        return imageView
    }
}
