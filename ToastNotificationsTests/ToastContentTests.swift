//
//  ToastContentTests.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/3/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
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

class TestFunction: XCTestCase {

    func testConvertTextElement() {

        let text = ToastElement.Text("")
        let rect = CGRect(x: 0, y: 0, width: 200, height: 100)

        let view = convert(text, rect: rect)
        XCTAssertTrue(view is UILabel)
        XCTAssertEqual(view.frame, rect)
    }

    func testConvertImageElement() {

        let image = ToastElement.Image("")
        let rect = CGRect(x: 0, y: 0, width: 200, height: 100)

        let view = convert(image, rect: rect)
        XCTAssertTrue(view is UIImageView)
        XCTAssertEqual(view.frame, rect)
    }


    // TODO: Move these to a separate file and use convenience method
    func testConvertToastContent() {

        let text = ToastContent(text: "")
        let rect = CGRect(x: 0, y: 0, width: 300, height: 100)

        let views = convert(rect, toastContent:text)

        XCTAssertEqual(views.count, 1)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    func testConvertToastContentCustomSize() {

        let text = ToastContent.Element(ToastSize(width: 2, height: 1), .Text(""))
        let rect = CGRect(x: 0, y: 0, width: 300, height: 100)

        let views = convert(rect, toastContent:text)

        XCTAssertEqual(views.count, 1)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 200, height: 100))
    }

    func testConvertToastContentsBeside() {

        let frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 100)
        let toast1 = ToastContent(text: "test1")
        let toast2 = ToastContent(text: "test2")

        let toastsBeside = toast1 ||| toast2

        let views = convert(frame, toastContent: toastsBeside)

        XCTAssertEqual(views.count, 2)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(views[1].frame, CGRect(x: 100, y: 0, width: 100, height: 100))
    }

    func testConvertToastContentsBesideCustomSize() {

        let frame: CGRect = CGRect(x: 0, y: 0, width: 500, height: 300)
        let toast1 = ToastContent.Element(ToastSize(width: 2, height: 1), .Text(""))
        let toast2 = ToastContent.Element(ToastSize(width: 2, height: 2), .Text(""))
        let toast3 = ToastContent.Element(ToastSize(width: 1, height: 3), .Text(""))

        let toastsBeside = toast1 ||| toast2 ||| toast3

        let views = convert(frame, toastContent: toastsBeside)

        XCTAssertEqual(views.count, 3)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 200, height: 100))
        XCTAssertEqual(views[1].frame, CGRect(x: 200, y: 0, width: 200, height: 200))
        XCTAssertEqual(views[2].frame, CGRect(x: 400, y: 0, width: 100, height: 300))
    }

    func testConvertToastContentStack() {

        let frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        let toast1 = ToastContent(text: "test1")
        let toast2 = ToastContent(text: "text2")

        let toastsStack = toast1 --- toast2

        let views = convert(frame, toastContent: toastsStack)

        XCTAssertEqual(views.count, 2)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(views[1].frame, CGRect(x: 0, y: 100, width: 100, height: 100))
    }

    func testConvertToastContentStackCustomSize() {

        let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        let toast1 = ToastContent.Element(ToastSize(width: 1, height: 2), .Text(""))
        let toast2 = ToastContent.Element(ToastSize(width: 2, height: 2), .Text(""))
        let toast3 = ToastContent.Element(ToastSize(width: 3, height: 1), .Text(""))

        let toastsStack = toast1 --- toast2 --- toast3

        let views = convert(frame, toastContent: toastsStack)

        XCTAssertEqual(views.count, 3)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 200))
        XCTAssertEqual(views[1].frame, CGRect(x: 0, y: 200, width: 200, height: 200))
        XCTAssertEqual(views[2].frame, CGRect(x: 0, y: 400, width: 300, height: 100))
    }
}

