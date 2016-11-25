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
        let text = ContentElement(text: "Test")
        let expected = ToastContent.element(size, text)

        let toast = ToastContent(text: "Test")

        XCTAssertEqual(expected, toast)
        XCTAssertEqual(toast.size, size)
    }

    func testImageContent() {

        let size = ContentSize(width: 1, height: 1)
        let image = ContentElement(imageName: "icon")
        let expected = ToastContent.element(size, image)
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

        let size = ContentSize(width: 2, height: 1)
        let testy = ContentElement(text: "Testy")
        let toasty = ContentElement(text: "Toast")

        let leftToast = ToastContent(size: size, element: testy)
        let rightToast = ToastContent(size: size, element: toasty)

        let besideToasts = ToastContent.beside(leftToast, rightToast)

        XCTAssertEqual(besideToasts.size, ContentSize(width: 4, height: 1))
    }

    func testBesideOpertor() {
        
        let size = ContentSize(width: 2, height: 1)
        let testy = ContentElement(text: "Testy")
        let toasty = ContentElement(text: "Toast")

        let leftToast = ToastContent(size: size, element: testy)
        let rightToast = ToastContent(size: size, element: toasty)

        let besideToasts = leftToast ||| rightToast

        XCTAssertEqual(besideToasts.size, ContentSize(width: 4, height: 1))
    }

    func testStackedOpertor() {

        let size = ContentSize(width: 2, height: 1)
        let testy = ContentElement(text: "Testy")
        let toasty = ContentElement(text: "Toast")

        let topToast = ToastContent(size: size, element: testy)
        let bottomToast = ToastContent(size: size, element: toasty)

        let stackedToasts = topToast --- bottomToast

        XCTAssertEqual(stackedToasts.size, ContentSize(width: 2, height: 2))
    }

    func testSameContent() {

        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(text: "Testy")

        let equal = aContent == bContent
        XCTAssertTrue(equal)
    }

    func testSameConentBeside() {
        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(text: "Testy")

        let aBeside = aContent ||| bContent
        let bBeside = bContent ||| aContent

        let equal = aBeside == bBeside
        XCTAssertTrue(equal)
    }

    func testSameContentStacked() {
        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(text: "Testy")

        let aStacked = aContent ||| bContent
        let bStacked = bContent ||| aContent

        let equal = aStacked == bStacked
        XCTAssertTrue(equal)
    }

    func testDifferentContent() {

        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(imageName: "icon")

        let different = aContent != bContent
        XCTAssertTrue(different)
    }

    func testDifferentConentBeside() {
        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(text: "Toasty")

        let aBeside = aContent ||| bContent
        let bBeside = bContent ||| aContent

        let different = aBeside != bBeside
        XCTAssertTrue(different)
    }

    func testDifferentContentStacked() {
        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(text: "Toasty")

        let aStacked = aContent ||| bContent
        let bStacked = bContent ||| aContent

        let different = aStacked != bStacked
        XCTAssertTrue(different)
    }

    func testDifferentContentValues() {
        let aContent = ToastContent(text: "Testy")
        let bContent = ToastContent(text: "Toasty")

        let besides = aContent ||| bContent
        let stacked = aContent --- bContent

        XCTAssertTrue(aContent != besides)
        XCTAssertTrue(stacked != aContent)
        XCTAssertTrue(besides != stacked)
    }
}

