//
//  ContentElementConverterTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ContentElementConverterTests: XCTestCase {

    func testConvertTextElement() {

        let text = ContentElement(text: "")

        let view = convert(text)
        XCTAssertTrue(view is UILabel)
        XCTAssertEqual(view.frame, CGRect.zero)
    }

    func testConvertImageElement() {

        let image = ContentElement(imageName: "")

        let view = convert(image)
        XCTAssertTrue(view is UIImageView)
        XCTAssertEqual(view.frame, CGRect.zero)
    }
}
