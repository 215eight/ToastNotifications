//
//  ContentElement.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**
 List of supported content elements

 + Text: Adds the text for that element
 + Image: Adds the image with specified named for that element
 */

indirect enum ContentElement {
    case text(String, TextAttribute)
    case image(String)

    init(text: String) {
        self = .text(text, TextAttribute())
    }

    init(imageName: String) {
        self = .image(imageName)
    }

    init(text: String , attribute: TextAttribute) {
        self = .text(text, attribute)
    }
}

extension ContentElement: Equatable { }

func == (lhs: ContentElement, rhs: ContentElement) -> Bool {
    switch (lhs, rhs) {
    case (.text(let lhsText, let lhsAttribute), .text(let rhsText, let rhsAttribute)):
        return lhsText == rhsText && lhsAttribute == rhsAttribute
    case (.image(let lhsName), .image(let rhsName)):
        return lhsName == rhsName
    case (.text(_, _), _),
         (.image(_), _):
        return false
    }
}
