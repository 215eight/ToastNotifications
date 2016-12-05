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
        let text = ContentElement(text: "Test")
        let expected = Content.element(size, text)

        let content = Content(text: "Test")

        XCTAssertEqual(expected, content)
        XCTAssertEqual(content.size, size)
    }

    func testImageContent() {

        let size = ContentSize(width: 1, height: 1)
        let image = ContentElement(imageName: "icon")
        let expected = Content.element(size, image)
        let content = Content(imageName: "icon")

        XCTAssertEqual(expected, content)
        XCTAssertEqual(content.size, size)
    }

    func testBesideElements() {

        let leftContent = Content(text: "Testy")
        let rightContent = Content(text: "Toasty")

        let besideContent = Content.beside(leftContent, rightContent)

        XCTAssertEqual(besideContent.size, ContentSize(width: 2, height: 1))
    }

    func testBesideElementsWithCustomSize() {

        let size = ContentSize(width: 2, height: 1)
        let testy = ContentElement(text: "Testy")
        let toasty = ContentElement(text: "Toast")

        let leftContent = Content(size: size, element: testy)
        let rightContent = Content(size: size, element: toasty)

        let besideContent = Content.beside(leftContent, rightContent)

        XCTAssertEqual(besideContent.size, ContentSize(width: 4, height: 1))
    }

    func testBesideOpertor() {
        
        let size = ContentSize(width: 2, height: 1)
        let testy = ContentElement(text: "Testy")
        let toasty = ContentElement(text: "Toast")

        let leftContent = Content(size: size, element: testy)
        let rightContent = Content(size: size, element: toasty)

        let besideContent = leftContent ||| rightContent

        XCTAssertEqual(besideContent.size, ContentSize(width: 4, height: 1))
    }

    func testStackedOpertor() {

        let size = ContentSize(width: 2, height: 1)
        let testy = ContentElement(text: "Testy")
        let toasty = ContentElement(text: "Toast")

        let topContent = Content(size: size, element: testy)
        let bottomContent = Content(size: size, element: toasty)

        let stackedContent = topContent --- bottomContent

        XCTAssertEqual(stackedContent.size, ContentSize(width: 2, height: 2))
    }

    func testComposeContent() {
        let leftTop = Content(size: ContentSize(width: 8, height: 1),
                                   element: ContentElement(text: "leftTop"))
        let leftBottom = Content(size: ContentSize(width: 8, height: 1),
                                   element: ContentElement(text: "leftBottom"))
        let right = Content(size: ContentSize(width: 2, height: 2),
                                 element: ContentElement(imageName: "test.png"))

        let content = (leftTop --- leftBottom) ||| right
        XCTAssertEqual(content.size, ContentSize(width: 10, height: 2))
    }

    func testSameContent() {

        let aContent = Content(text: "Testy")
        let bContent = Content(text: "Testy")

        let equal = aContent == bContent
        XCTAssertTrue(equal)
    }

    func testSameConentBeside() {
        let aContent = Content(text: "Testy")
        let bContent = Content(text: "Testy")

        let aBeside = aContent ||| bContent
        let bBeside = bContent ||| aContent

        let equal = aBeside == bBeside
        XCTAssertTrue(equal)
    }

    func testSameContentStacked() {
        let aContent = Content(text: "Testy")
        let bContent = Content(text: "Testy")

        let aStacked = aContent ||| bContent
        let bStacked = bContent ||| aContent

        let equal = aStacked == bStacked
        XCTAssertTrue(equal)
    }

    func testDifferentContent() {

        let aContent = Content(text: "Testy")
        let bContent = Content(imageName: "icon")

        let different = aContent != bContent
        XCTAssertTrue(different)
    }

    func testDifferentConentBeside() {
        let aContent = Content(text: "Testy")
        let bContent = Content(text: "Toasty")

        let aBeside = aContent ||| bContent
        let bBeside = bContent ||| aContent

        let different = aBeside != bBeside
        XCTAssertTrue(different)
    }

    func testDifferentContentStacked() {
        let aContent = Content(text: "Testy")
        let bContent = Content(text: "Toasty")

        let aStacked = aContent --- bContent
        let bStacked = bContent --- aContent

        let different = aStacked != bStacked
        XCTAssertTrue(different)
    }

    func testDifferentContentValues() {
        let aContent = Content(text: "Testy")
        let bContent = Content(text: "Toasty")

        let besides = aContent ||| bContent
        let stacked = aContent --- bContent

        XCTAssertTrue(aContent != besides)
        XCTAssertTrue(stacked != aContent)
        XCTAssertTrue(besides != stacked)
    }
}

