//
//  ToastElementConverterTests.swift
//  ToastNotifications
//
//  Created by PartyMan on 6/12/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastElementConverterTests: XCTestCase {

    func testConvertTextElement() {

        let text = ToastElement(text: "")
        let frame = CGRect(x: 0, y: 0, width: 200, height: 100)

        let view = convert(text, frame: frame)
        XCTAssertTrue(view is UILabel)
        XCTAssertEqual(view.frame, frame)
    }

    func testConvertImageElement() {

        let image = ToastElement(imageName: "")
        let frame = CGRect(x: 0, y: 0, width: 200, height: 100)

        let view = convert(image, frame: frame)
        XCTAssertTrue(view is UIImageView)
        XCTAssertEqual(view.frame, frame)
    }
}
