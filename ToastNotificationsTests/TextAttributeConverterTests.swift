//
//  TextAttributeConverterTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastAttributeConverterTests: XCTestCase {

    func testConvertFontAttribute() {

        let font = UIFont.systemFont(ofSize: 12)

        let fontAttribute = TextAttribute.font(font)

        let attributes = convert(attribute: fontAttribute)

        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes[NSFontAttributeName] as? UIFont, font)
    }

    func testConvertAlignmentAttribute() {

        let alignment: NSTextAlignment = .center

        let alignmentAttribute = TextAttribute.alignment(alignment)

        let attributes = convert(attribute: alignmentAttribute)

        XCTAssertEqual(attributes.count, 1)

        let actualAlignment = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle
        XCTAssertEqual(actualAlignment?.alignment, alignment)
    }

    func testConvertBackgroundColor() {

        let backgroundColor = UIColor.clear

        let colorAttribute = TextAttribute.backgroundColor(backgroundColor)

        let attributes = convert(attribute: colorAttribute)

        XCTAssertEqual(attributes.count, 1)

        let actualColor = attributes[NSBackgroundColorAttributeName] as? UIColor
        XCTAssertEqual(actualColor, backgroundColor)
    }

    func testConvertForegroundColor() {

        let color = UIColor.black

        let colorAttribute = TextAttribute.foregroundColor(color)

        let attributes = convert(attribute: colorAttribute)

        XCTAssertEqual(attributes.count, 1)

        let actualColor = attributes[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(actualColor, color)
    }

    func testTextAttributeComposition() {

        let font = UIFont.systemFont(ofSize: 12)
        let color = UIColor.black

        let textAttributes = TextAttribute.font(font)
                                          .map{ .foregroundColor(color) }

        let attributes = convert(attribute: textAttributes)

        XCTAssertEqual(attributes.count, 2)
        XCTAssertEqual(attributes[NSFontAttributeName] as? UIFont, font)

        let actualColor = attributes[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(actualColor, color)
    }

    func testConvertTextAttributeOverride() {

        let font1 = UIFont.systemFont(ofSize: 12)
        let font2 = UIFont.systemFont(ofSize: 16)

        let attribute1 = TextAttribute.font(font1)
        let attribute2 = TextAttribute.font(font2)

        let textAttributes = TextAttribute.compose(attribute1, attribute2)

        let attributes = convert(attribute: textAttributes)

        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes[NSFontAttributeName] as? UIFont, font2)
    }

    func testDefaultTextAttributes() {

        let attributes = convert(attribute: TextAttribute())

        let expectedFont = UIFont.systemFont(ofSize: 16)
        let actualFont = attributes[NSFontAttributeName] as? UIFont
        XCTAssertEqual(expectedFont, actualFont)

        let expectedAlignment = NSTextAlignment.center
        let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle
        let actualAlignment = paragraphStyle!.alignment
        XCTAssertEqual(expectedAlignment, actualAlignment)

        let expectedColor = UIColor.black
        let actualColor = attributes[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(expectedColor, actualColor)

        let expectedBackgroundColor = UIColor.clear
        let actualBackgroundColor = attributes[NSBackgroundColorAttributeName] as? UIColor
        XCTAssertEqual(expectedBackgroundColor, actualBackgroundColor)
    }
}
