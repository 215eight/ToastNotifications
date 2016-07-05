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
    case Text(String, TextAttribute)
    case Image(String)

    init(text: String) {
        self = .Text(text, TextAttribute())
    }

    init(imageName: String) {
        self = .Image(imageName)
    }

    init(text: String , attribute: TextAttribute) {
        self = .Text(text, attribute)
    }
}

extension ContentElement: Equatable { }

func == (lhs: ContentElement, rhs: ContentElement) -> Bool {
    switch (lhs, rhs) {
    case (.Text(let lhsText, let lhsAttribute), .Text(let rhsText, let rhsAttribute)):
        return lhsText == rhsText && lhsAttribute == rhsAttribute
    case (.Image(let lhsName), .Image(let rhsName)):
        return lhsName == rhsName
    case (.Text(_, _), _),
         (.Image(_), _):
        return false
    }
}
