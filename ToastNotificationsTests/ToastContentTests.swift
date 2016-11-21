//
//  ToastContentTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/3/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastContentTests: XCTestCase {

    func testTextContent() {

        let size = ContentSize(width: 1, height: 1)
        let expected = ToastContent.element(size,
                                            ContentElement(text: "Test"))
        let toast = ToastContent(text: "Test")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testImageContent() {

        let size = ContentSize(width: 1, height: 1)
        let expected = ToastContent.element(size, .image("icon"))
        let toast = ToastContent(imageName: "icon")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testBesideElements() {

        let leftToast = ToastContent(text: "Testy")
        let rightToast = ToastContent(text: "Toasty")

        let besideToasts = ToastContent.beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ContentSize(width: 2, height: 1))
    }

    func testBesideElementsWithCustomSize() {

        let leftToast = ToastContent.element(ContentSize(width: 2, height: 1),
                                             ContentElement(text: "Testy"))
        let rightToast = ToastContent.element(ContentSize(width: 2, height: 1),
                                              ContentElement(text: "Testy"))

        let besideToasts = ToastContent.beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ContentSize(width: 4, height: 1))
    }

    func testBesideOpertor() {

        let leftToast = ToastContent.element(ContentSize(width: 2, height: 1),
                                             ContentElement(text: "Testy"))
        let rightToast = ToastContent.element(ContentSize(width: 2, height: 1),
                                              ContentElement(text: "Testy"))

        let besideToasts = leftToast ||| rightToast

        XCTAssertEqual(besideToasts.size, ContentSize(width: 4, height: 1))
    }

    func testStackedOpertor() {

        let topToast = ToastContent.element(ContentSize(width: 2, height: 1),
                                            ContentElement(text: "Testy"))
        let bottomToast = ToastContent.element(ContentSize(width: 2, height: 1),
                                               ContentElement(text: "Testy"))

        let stackedToasts = topToast --- bottomToast

        XCTAssertEqual(stackedToasts.size, ContentSize(width: 2, height: 2))
    }
}

