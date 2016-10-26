//
//  Content.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**
 Model of text or image content arranged in a grid layout positione beside or
 stacked relative to each other

 + Element: A content element and its size relative to other elements that compose
 the whole content

 + Beside: Two content items positioned side by side

 + Stack: Two content items positioned against each other
 */
indirect enum Content {

    case element(ContentSize, ContentElement)
    case beside(Content, Content)
    case stack(Content, Content)

    /**
     Creates a text content element of size 1x1
     */
    init(text: String) {
        let size = ContentSize(width: 1, height: 1)
        self = .element(size, ContentElement(text: text))
    }

    /**
     Creates an image content element of size 1x1
     */
    init(imageName: String) {
        let size = ContentSize(width: 1, height: 1)
        self = .element(size, .image(imageName))
    }

    init(size: ContentSize, element: ContentElement) {
        self = .element(size, element)
    }

    /**
     Returns logical size of the content.
     */
    var size: ContentSize {
        switch self {
        case .element(let size, _):
            return size

        case .beside(let lhs, let rhs):
            let width = lhs.size.width + rhs.size.width
            let height = max(lhs.size.height, rhs.size.height)
            let size = ContentSize(width: width, height: height)
            return size

        case .stack(let lhs, let rhs):
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

    case (.element(let lhsSize, let lhsElement),
          .element(let rhsSize, let rhsElement)):
        return lhsSize == rhsSize && lhsElement == rhsElement

    case (.beside(let lhsLeft, let lhsRight),
          .beside(let rhsLeft, let rhsRight)):
        return lhsLeft == rhsLeft && lhsRight == rhsRight

    case (.stack(let lhsLeft, let lhsRight),
        .stack(let rhsLeft, let rhsRight)):
        return lhsLeft == rhsLeft && lhsRight == rhsRight

    case (.element(_,_), _),
         (.beside(_,_), _),
         (.stack(_,_), _):
        return false
    }
}

/**
 Returns a new `Content` with the content of lhs and rhs beside each other
 */
infix operator ||| : AdditionPrecedence

func |||(lhs: Content, rhs: Content) -> Content {
    return Content.beside(lhs, rhs)
}

/**
 Returns a new `Content` with the content of top and bottom stack against
 each other
 */
infix operator --- : AdditionPrecedence

func ---(top: Content, bottom: Content) -> Content {
    return Content.stack(top, bottom)
}
