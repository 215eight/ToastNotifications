//
//  UIImageExtensionsTests.swift
//  ToastNotifications
//
//  Created by pman215 on 11/26/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class UIImageExtensionsTests: XCTestCase {

    func testExistingImage() {
        let image = UIImage.nonNullImage(name: "test.png")
        XCTAssertEqual(image.size, CGSize(width: 141, height: 37))
    }

    func testEmptyImage() {
        let image = UIImage.nonNullImage(name: "_empty_")
        XCTAssertEqual(image.size, CGSize.zero)
    }
}
