//
//  ToastContent.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit


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

        self = .Element(ToastSize(), ToastElement(text: ""))
    }

    /**
     Creates a toast content with a single text element of size 1x1
     */
    init(text: String) {

        let size = ToastSize(width: 1, height: 1)
        self = .Element(size, ToastElement(text: text))
    }

    /**
     Creates a toast content with a single image element of size 1x1
     */
    init(imageName: String) {

        let size = ToastSize(width: 1, height: 1)
        self = .Element(size, .Image(imageName))
    }

    init(size: ToastSize, element: ToastElement) {
        self = .Element(size, element)
    }

    /**
     Returns logical size of the content.
     */
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

    case (.Element(let lhsSize, let lhsElement),
          .Element(let rhsSize, let rhsElement)):
        return lhsSize == rhsSize && lhsElement == rhsElement

    case (.Beside(let lhsLeft, let lhsRight),
          .Beside(let rhsLeft, let rhsRight)):
        return lhsLeft == rhsLeft && lhsRight == rhsRight

    default:
        return false
    }
}

/**
 Returns a new `ToastContent` with the content of lhs and rhs beside each other
 */
infix operator ||| { associativity left }

func |||(lhs: ToastContent, rhs: ToastContent) -> ToastContent {

    return ToastContent.Beside(lhs, rhs)
}

/**
 Returns a new `ToasContent` with the content of top and bottom stack against
 each other
 */
infix operator --- { associativity left }

func ---(top: ToastContent, bottom: ToastContent) -> ToastContent {

    return ToastContent.Stack(top, bottom)
}
