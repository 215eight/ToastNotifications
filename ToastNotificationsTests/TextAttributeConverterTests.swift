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

        let font = UIFont.systemFontOfSize(12)

        let fontAttribute = TextAttribute.Font(font)

        let attributes = convert(fontAttribute)

        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes[NSFontAttributeName] as? UIFont, font)
    }

    func testConvertAlignmentAttribute() {

        let alignment: NSTextAlignment = .Center

        let alignmentAttribute = TextAttribute.Alignment(alignment)

        let attributes = convert(alignmentAttribute)

        XCTAssertEqual(attributes.count, 1)

        let actualAlignment = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle
        XCTAssertEqual(actualAlignment?.alignment, alignment)
    }

    func testConvertBackgroundColor() {

        let backgroundColor = UIColor.clearColor()

        let colorAttribute = TextAttribute.BackgroundColor(backgroundColor)

        let attributes = convert(colorAttribute)

        XCTAssertEqual(attributes.count, 1)

        let actualColor = attributes[NSBackgroundColorAttributeName] as? UIColor
        XCTAssertEqual(actualColor, backgroundColor)
    }

    func testConvertForegroundColor() {

        let color = UIColor.blackColor()

        let colorAttribute = TextAttribute.ForegroundColor(color)

        let attributes = convert(colorAttribute)

        XCTAssertEqual(attributes.count, 1)

        let actualColor = attributes[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(actualColor, color)
    }

    func testTextAttributeComposition() {

        let font = UIFont.systemFontOfSize(12)
        let color = UIColor.blackColor()

        let textAttributes = TextAttribute.Font(font)
                                          .map{ .ForegroundColor(color) }

        let attributes = convert(textAttributes)

        XCTAssertEqual(attributes.count, 2)
        XCTAssertEqual(attributes[NSFontAttributeName] as? UIFont, font)

        let actualColor = attributes[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(actualColor, color)
    }

    func testConvertTextAttributeOverride() {

        let font1 = UIFont.systemFontOfSize(12)
        let font2 = UIFont.systemFontOfSize(16)

        let attribute1 = TextAttribute.Font(font1)
        let attribute2 = TextAttribute.Font(font2)

        let textAttributes = TextAttribute.Compose(attribute1, attribute2)

        let attributes = convert(textAttributes)

        XCTAssertEqual(attributes.count, 1)
        XCTAssertEqual(attributes[NSFontAttributeName] as? UIFont, font2)
    }

    func testDefaultTextAttributes() {

        let attributes = convert(TextAttribute())

        let expectedFont = UIFont.systemFontOfSize(16)
        let actualFont = attributes[NSFontAttributeName] as? UIFont
        XCTAssertEqual(expectedFont, actualFont)

        let expectedAlignment = NSTextAlignment.Center
        let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSParagraphStyle
        let actualAlignment = paragraphStyle!.alignment
        XCTAssertEqual(expectedAlignment, actualAlignment)

        let expectedColor = UIColor.blackColor()
        let actualColor = attributes[NSForegroundColorAttributeName] as? UIColor
        XCTAssertEqual(expectedColor, actualColor)

        let expectedBackgroundColor = UIColor.clearColor()
        let actualBackgroundColor = attributes[NSBackgroundColorAttributeName] as? UIColor
        XCTAssertEqual(expectedBackgroundColor, actualBackgroundColor)
    }
}
