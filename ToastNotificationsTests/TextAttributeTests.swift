//
//  TextAttributeTests.swift
//  ToastNotifications
//
//  Created by pman215 on 11/26/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class TextAttributeTests: XCTestCase {

    func testFontAttribute() {
        let fontName = "AvenirNextCondensed-UltraLight"
        let fontSize: CGFloat = 14

        let attribute = TextAttribute(fontName: fontName, size: fontSize)

        if case let .font(font) = attribute {
            XCTAssertEqual(font.fontName, fontName)
            XCTAssertEqual(font.pointSize, fontSize)
        } else {
            XCTFail()
        }
    }

    func testAlignmentAttribute() {
        let center: NSTextAlignment = .center

        let attribute = TextAttribute(alignment: center)

        if case let .alignment(alignment) = attribute {
            XCTAssertEqual(alignment, center)
        } else {
            XCTFail()
        }
    }

    func testForegroundColor() {
        let black: UIColor = .black

        let attribute = TextAttribute(color: black)

        if case let .foregroundColor(color) = attribute {
            XCTAssertEqual(color, black)
        } else {
            XCTFail()
        }
    }

    func testBackgroundColor() {
        let black: UIColor = .black

        let attribute = TextAttribute(backgroundColor: black)

        if case let .backgroundColor(color) = attribute {
            XCTAssertEqual(color, black)
        } else {
            XCTFail()
        }
    }

    func testComposeAttributes() {
        let color = TextAttribute(color: .white)
        let backgrondColor = TextAttribute(color: .black)

        let attributes = color.map { backgrondColor }

        if case let .compose(_color, _backgroundColor) = attributes {
            XCTAssertEqual(_color, color)
            XCTAssertEqual(_backgroundColor, backgrondColor)
        } else {
            XCTFail()
        }
    }

    func testSameAttributesComparison() {
        let blackColor = TextAttribute(color: .black)
        let aBlackColor = TextAttribute(color: .black)

        XCTAssertEqual(blackColor, aBlackColor)
        XCTAssertEqual(aBlackColor, blackColor)
    }

    func testSameComposedAttributesComparison() {
        let blackColor = TextAttribute(color: .black)
        let center = TextAttribute(alignment: .center)

        let aAttr = blackColor.map{ center }
        let bAttr = TextAttribute.compose(blackColor, center)

        XCTAssertEqual(aAttr, bAttr)
        XCTAssertEqual(bAttr, aAttr)
    }

    func testDifferentAttributesComparison() {
        let blackColor = TextAttribute(color: .black)
        let whiteColor = TextAttribute(color: .white)

        XCTAssertNotEqual(blackColor, whiteColor)
        XCTAssertNotEqual(whiteColor, blackColor)
    }

    func testDifferentAttributeTypeComparison() {
        let center = TextAttribute(alignment: .center)
        let black = TextAttribute(color: .black)

        XCTAssertNotEqual(center, black)
        XCTAssertNotEqual(black, center)
    }

    func testDifferentComposedAttributesComparison() {
        let blackColor = TextAttribute(color: .black)
        let center = TextAttribute(alignment: .center)

        let aAttr = blackColor.map{ center }
        let bAttr = TextAttribute.compose(center, blackColor)

        XCTAssertNotEqual(aAttr, bAttr)
        XCTAssertNotEqual(bAttr, aAttr)
    }
}
