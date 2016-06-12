//
//  CGRectExtensionsTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/5/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class CGRectExtensionsTests: XCTestCase {

    func testSplitRect() {

        let rect = CGRect(x: 0, y: 0, width: 200, height: 50)
        let (lhs, rhs) = rect.split(0.5, edge: .MinXEdge)

        XCTAssertEqual(lhs, CGRect(x: 0, y: 0, width: 100, height: 50))
        XCTAssertEqual(rhs, CGRect(x: 100, y: 0, width: 100, height: 50))
    }

    func testSplitRectEdge() {
        let rect = CGRect(x: 0, y: 0, width: 200, height: 50)
        let (lhs, rhs) = rect.split(0.5, edge: .MaxXEdge)

        XCTAssertEqual(lhs, CGRect(x: 0, y: 0, width: 100, height: 50))
        XCTAssertEqual(rhs, CGRect(x: 100, y: 0, width: 100, height: 50))
    }
}