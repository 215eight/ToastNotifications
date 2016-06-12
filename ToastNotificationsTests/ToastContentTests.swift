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

    func testEmptyToastContent() {

        let expected = ToastContent.Element(ToastSize(), .Text(""))
        let toast = ToastContent()

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, ToastSize())
    }

    func testTextToastContent() {

        let size = ToastSize(width: 1, height: 1)
        let expected = ToastContent.Element(size, .Text("Test"))
        let toast = ToastContent(text: "Test")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testImageToastContent() {

        let size = ToastSize(width: 1, height: 1)
        let expected = ToastContent.Element(size, .Image("icon"))
        let toast = ToastContent(imageName: "icon")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testBesideElements() {

        let leftToast = ToastContent(text: "Testy")
        let rightToast = ToastContent(text: "Toasty")

        let besideToasts = ToastContent.Beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ToastSize(width: 2, height: 1))
    }

    func testBesideElementsWithCustomSize() {

        let leftToast = ToastContent.Element(ToastSize(width: 2, height: 1), .Text("Testy"))
        let rightToast = ToastContent.Element(ToastSize(width: 2, height: 1), .Text("Testy"))

        let besideToasts = ToastContent.Beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ToastSize(width: 4, height: 1))
    }

    func testBesideOpertor() {

        let leftToast = ToastContent.Element(ToastSize(width: 2, height: 1), .Text("Testy"))
        let rightToast = ToastContent.Element(ToastSize(width: 2, height: 1), .Text("Testy"))

        let besideToasts = leftToast ||| rightToast

        XCTAssertEqual(besideToasts.size, ToastSize(width: 4, height: 1))
    }
}

