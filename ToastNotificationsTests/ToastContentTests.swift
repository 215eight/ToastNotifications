//
//  ContentTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/3/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ContentTests: XCTestCase {

    func testTextContent() {

        let size = ContentSize(width: 1, height: 1)
        let expected = Content.element(size,
                                            ContentElement(text: "Test"))
        let toast = Content(text: "Test")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testImageContent() {

        let size = ContentSize(width: 1, height: 1)
        let expected = Content.element(size, .image("icon"))
        let toast = Content(imageName: "icon")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testBesideElements() {

        let leftToast = Content(text: "Testy")
        let rightToast = Content(text: "Toasty")

        let besideToasts = Content.beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ContentSize(width: 2, height: 1))
    }

    func testBesideElementsWithCustomSize() {

        let leftToast = Content.element(ContentSize(width: 2, height: 1),
                                             ContentElement(text: "Testy"))
        let rightToast = Content.element(ContentSize(width: 2, height: 1),
                                              ContentElement(text: "Testy"))

        let besideToasts = Content.beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ContentSize(width: 4, height: 1))
    }

    func testBesideOpertor() {

        let leftToast = Content.element(ContentSize(width: 2, height: 1),
                                             ContentElement(text: "Testy"))
        let rightToast = Content.element(ContentSize(width: 2, height: 1),
                                              ContentElement(text: "Testy"))

        let besideToasts = leftToast ||| rightToast

        XCTAssertEqual(besideToasts.size, ContentSize(width: 4, height: 1))
    }
}

