//
//  ToastContentConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/11/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastContentConverter: XCTestCase {

    func testConvertToastContent() {

        let text = ToastContent(text: "")
        let frame = CGRect(x: 0, y: 0, width: 300, height: 100)

        let views = convert(text, frame: frame)

        XCTAssertEqual(views.count, 1)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    func testConvertToastContentCustomSize() {

        let text = ToastContent.Element(ToastSize(width: 2, height: 1),
                                        ToastElement(text: ""))
        let frame = CGRect(x: 0, y: 0, width: 300, height: 100)

        let views = convert(text, frame: frame)

        XCTAssertEqual(views.count, 1)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 200, height: 100))
    }

    func testConvertToastContentsBeside() {

        let frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 100)
        let leftContent = ToastContent(text: "test1")
        let rightContent = ToastContent(text: "test2")

        let content = leftContent ||| rightContent

        let views = convert(content, frame: frame)

        XCTAssertEqual(views.count, 2)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(views[1].frame, CGRect(x: 100, y: 0, width: 100, height: 100))
    }

    func testConvertToastContentsBesideCustomSize() {

        let frame: CGRect = CGRect(x: 0, y: 0, width: 500, height: 300)
        let leftContent = ToastContent.Element(ToastSize(width: 2, height: 1),
                                               ToastElement(text: ""))
        let centerContent = ToastContent.Element(ToastSize(width: 2, height: 2),
                                                 ToastElement(text: ""))
        let rightContent = ToastContent.Element(ToastSize(width: 1, height: 3),
                                                ToastElement(text: ""))

        let content = leftContent ||| centerContent ||| rightContent

        let views = convert(content, frame: frame)

        XCTAssertEqual(views.count, 3)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 200, height: 100))
        XCTAssertEqual(views[1].frame, CGRect(x: 200, y: 0, width: 200, height: 200))
        XCTAssertEqual(views[2].frame, CGRect(x: 400, y: 0, width: 100, height: 300))
    }

    func testConvertToastContentStack() {

        let frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        let topContent = ToastContent(text: "test1")
        let bottomContent = ToastContent(text: "text2")

        let content = topContent --- bottomContent

        let views = convert(content, frame: frame)

        XCTAssertEqual(views.count, 2)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(views[1].frame, CGRect(x: 0, y: 100, width: 100, height: 100))
    }

    func testConvertToastContentStackCustomSize() {

        let frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        let topContent = ToastContent.Element(ToastSize(width: 1, height: 2),
                                              ToastElement(text: ""))
        let middleContent = ToastContent.Element(ToastSize(width: 2, height: 2),
                                                 ToastElement(text: ""))
        let bottomContent = ToastContent.Element(ToastSize(width: 3, height: 1),
                                                 ToastElement(text: ""))

        let content = topContent --- middleContent --- bottomContent

        let views = convert(content, frame: frame)

        XCTAssertEqual(views.count, 3)
        XCTAssertEqual(views[0].frame, CGRect(x: 0, y: 0, width: 100, height: 200))
        XCTAssertEqual(views[1].frame, CGRect(x: 0, y: 200, width: 200, height: 200))
        XCTAssertEqual(views[2].frame, CGRect(x: 0, y: 400, width: 300, height: 100))
    }
}
