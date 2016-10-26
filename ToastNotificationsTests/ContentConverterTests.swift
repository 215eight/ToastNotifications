//
//  ContentConverterTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/11/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ContentConverterTests: XCTestCase {

    func testConvertContent() {

        let content = Content(text: "Toast")
        let contentView = convert(content: content)
        let constraints = contentView.constraints

        XCTAssertEqual(constraints.count, 4)

        let widthConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(widthConstraint))

        let heightConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(heightConstraint))

        let centerXConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        XCTAssertTrue(constraints.contains(centerXConstraint))

        let centerYConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        XCTAssertTrue(constraints.contains(centerYConstraint))
    }

    func testConvertContentBeside() {

        let leftContent = Content(text: "Left")
        let rightContent = Content(text: "Right")
        let content = leftContent ||| rightContent
        let contentView = convert(content: content)

        let constraints = contentView.constraints

        XCTAssertEqual(constraints.count, 8)

        let leftViewWidth = NSLayoutConstraint(item: contentView.subviews.first!,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .width,
                                               multiplier: 0.5,
                                               constant: 0)
        XCTAssertTrue(constraints.contains(leftViewWidth))

        let rightViewWidth = NSLayoutConstraint(item: contentView.subviews.last!,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .width,
                                                multiplier: 0.5,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(rightViewWidth))

        let leftViewHeight = NSLayoutConstraint(item: contentView.subviews.first!,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .height,
                                                multiplier: 1,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(leftViewHeight))

        let rightViewHeight = NSLayoutConstraint(item: contentView.subviews.last!,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .height,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(rightViewHeight))

        let leftViewCenterX = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .centerX,
                                                 multiplier: 0.5,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(leftViewCenterX))

        let rightViewCenterX = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerX,
                                                  multiplier: 1.5,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(rightViewCenterX))

        let leftViewCenterY = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(leftViewCenterY))

        let rightViewCenterY = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(rightViewCenterY))

    }

    func testConvertContentStack() {

        let topContent = Content(text: "Top")
        let bottomContent = Content(text: "Bottom")
        let content = topContent --- bottomContent
        let contentView = convert(content: content)

        let constraints = contentView.constraints
        XCTAssertEqual(constraints.count, 8)

        let topViewWidth = NSLayoutConstraint(item: contentView.subviews.first!,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .width,
                                               multiplier: 1,
                                               constant: 0)
        XCTAssertTrue(constraints.contains(topViewWidth))

        let bottomViewWidth = NSLayoutConstraint(item: contentView.subviews.last!,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .width,
                                                multiplier: 1,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewWidth))

        let topViewHeight = NSLayoutConstraint(item: contentView.subviews.first!,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .height,
                                                multiplier: 0.5,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(topViewHeight))

        let bottomViewHeight = NSLayoutConstraint(item: contentView.subviews.last!,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .height,
                                                 multiplier: 0.5,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewHeight))

        let topViewCenterX = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .centerX,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(topViewCenterX))

        let bottomViewCenterX = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerX,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewCenterX))

        let topViewCenterY = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .centerY,
                                                 multiplier: 0.5,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(topViewCenterY))

        let bottomViewCenterY = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerY,
                                                  multiplier: 1.5,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewCenterY))
    }
}
