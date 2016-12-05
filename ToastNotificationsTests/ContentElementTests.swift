//
//  ContentElementTests.swift
//  ToastNotifications
//
//  Created by pman215 on 11/26/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ContentElementTests: XCTestCase {

    func testTextElement() {
        let text = ContentElement(text: "Toast")
        XCTAssertNotNil(text)
    }

    func testTextElementWithAttribute() {
        let attribute = TextAttribute.alignment(.center)
        let text = ContentElement(text: "Toast", attributes: attribute)
        XCTAssertNotNil(text)
    }

    func testImageElement() {
        let image = ContentElement(imageName: "icon")
        XCTAssertNotNil(image)
    }
}
