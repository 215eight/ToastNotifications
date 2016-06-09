//
//  ToastContent.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
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


// MARK: Toast Content

indirect enum ToastContent {

    case Element(ToastSize, ToastElement)
    case Beside(ToastContent, ToastContent)
    case Stack(ToastContent, ToastContent)

    init() {

        self = .Element(ToastSize(), .Text(""))
    }

    init(text: String) {

        let size = ToastSize(width: 1, height: 1)
        self = .Element(size, .Text(text))
    }

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

func convert(rect: CGRect, toastContent: ToastContent) -> [UIView] {

    var views = [UIView]()

    switch toastContent {

    case .Element(let size, let element):
        let frame = size.fit(rect)
        let view = convert(element, rect: frame)
        views.append(view)

    case .Beside(let lhs, let rhs):
        let widthRatio = CGFloat((lhs.size / toastContent.size).width)
        let (leftRect, rightRect) = rect.split(widthRatio, edge: .MinXEdge)
        views.appendContentsOf( [(leftRect, lhs), (rightRect, rhs)]
                                .flatMap { convert($0.0, toastContent: $0.1) } )

    case .Stack(let lhs, let rhs):
        let heightRatio = CGFloat((lhs.size / toastContent.size).height)
        let (topRect, bottomRect) = rect.split(heightRatio, edge: .MinYEdge)
        views.appendContentsOf( [(topRect, lhs), (bottomRect, rhs)]
                                .flatMap { convert($0.0, toastContent: $0.1) } )
    }

    return views
}

func convert(element: ToastElement, rect: CGRect) -> UIView {

    switch element {

    case .Text(let text):
        let label = UILabel(frame: rect)
        label.text = text
        return label

    case .Image(let name):
        let image = UIImage.nonNullImage(name)
        let imageView = UIImageView(frame: rect)
        imageView.image = image
        return imageView
    }
}