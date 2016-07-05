//
//  Content.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit


/**
 Models of content that contain content elements with a certain layout

 + Element: A content element and its size relative to other elements that are
 part of the same content

 + Beside: Two content items positioned side by side

 + Stack: Two content items positioned against each other
 */
indirect enum Content {

    case Element(ContentSize, ContentElement)
    case Beside(Content, Content)
    case Stack(Content, Content)

    /**
     Creates a text content element of size 1x1
     */
    init(text: String) {

        let size = ContentSize(width: 1, height: 1)
        self = .Element(size, ContentElement(text: text))
    }

    /**
     Creates an image content element of size 1x1
     */
    init(imageName: String) {

        let size = ContentSize(width: 1, height: 1)
        self = .Element(size, .Image(imageName))
    }

    init(size: ContentSize, element: ContentElement) {
        self = .Element(size, element)
    }

    /**
     Returns logical size of the content.
     */
    var size: ContentSize {

        switch self {

        case .Element(let size, _):
            return size

        case .Beside(let lhs, let rhs):
            let width = lhs.size.width + rhs.size.width
            let height = max(lhs.size.height, rhs.size.height)
            let size = ContentSize(width: width, height: height)
            return size

        case .Stack(let lhs, let rhs):
            let width = max(lhs.size.width, rhs.size.width)
            let height = lhs.size.height + rhs.size.height
            let size = ContentSize(width: width, height: height)
            return size
        }
    }
}

extension Content: Equatable { }

func ==(lhs: Content, rhs: Content) -> Bool {

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
 Returns a new `Content` with the content of lhs and rhs beside each other
 */
infix operator ||| { associativity left }

func |||(lhs: Content, rhs: Content) -> Content {

    return Content.Beside(lhs, rhs)
}

/**
 Returns a new `Content` with the content of top and bottom stack against
 each other
 */
infix operator --- { associativity left }

func ---(top: Content, bottom: Content) -> Content {

    return Content.Stack(top, bottom)
}
