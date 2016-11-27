//
//  ToastContentConverterTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/11/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastContentConverterTests: XCTestCase {

    func testConvertToastContent() {

        let content = ToastContent(text: "Toast")
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
        XCTAssertTrue(widthConstraint.present(in: constraints))

        let heightConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(heightConstraint.present(in: constraints))

        let centerXConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        XCTAssertTrue(centerXConstraint.present(in: constraints))

        let centerYConstraint = NSLayoutConstraint(item: contentView.subviews.first!,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        XCTAssertTrue(centerYConstraint.present(in: constraints))
    }

    func testConvertToastContentBeside() {

        let leftToastContent = ToastContent(text: "Left")
        let rightToastContent = ToastContent(text: "Right")
        let content = leftToastContent ||| rightToastContent
        let contentView = convert(content: content)

        let leftViewWidth = NSLayoutConstraint(item: contentView.subviews.first!,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .width,
                                               multiplier: 0.5,
                                               constant: 0)

        let rightViewWidth = NSLayoutConstraint(item: contentView.subviews.last!,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .width,
                                                multiplier: 0.5,
                                                constant: 0)

        let leftViewHeight = NSLayoutConstraint(item: contentView.subviews.first!,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .height,
                                                multiplier: 1,
                                                constant: 0)

        let rightViewHeight = NSLayoutConstraint(item: contentView.subviews.last!,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .height,
                                                 multiplier: 1,
                                                 constant: 0)

        let leftViewCenterX = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .centerX,
                                                 multiplier: 0.5,
                                                 constant: 0)

        let rightViewCenterX = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerX,
                                                  multiplier: 1.5,
                                                  constant: 0)

        let leftViewCenterY = NSLayoutConstraint(item: contentView.subviews.first!,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0)

        let rightViewCenterY = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .centerY,
                                                  multiplier: 1,
                                                  constant: 0)

        let expectedConstraints = [leftViewWidth, leftViewHeight, leftViewCenterX, leftViewCenterY,
                                   rightViewWidth, rightViewHeight, rightViewCenterX, rightViewCenterY]

        contentView.constraints.map { $0.present(in: expectedConstraints) }
                               .forEach { XCTAssertTrue($0) }
    }

    func testConvertToastContentStack() {

        let topToastContent = ToastContent(text: "Top")
        let bottomToastContent = ToastContent(text: "Bottom")
        let content = topToastContent --- bottomToastContent
        let contentView = convert(content: content)


        let topViewWidth = NSLayoutConstraint(item: contentView.subviews.first!,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: contentView,
                                              attribute: .width,
                                              multiplier: 1,
                                              constant: 0)

        let bottomViewWidth = NSLayoutConstraint(item: contentView.subviews.last!,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0)

        let topViewHeight = NSLayoutConstraint(item: contentView.subviews.first!,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .height,
                                               multiplier: 0.5,
                                               constant: 0)

        let bottomViewHeight = NSLayoutConstraint(item: contentView.subviews.last!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: contentView,
                                                  attribute: .height,
                                                  multiplier: 0.5,
                                                  constant: 0)

        let topViewCenterX = NSLayoutConstraint(item: contentView.subviews.first!,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .centerX,
                                                multiplier: 1,
                                                constant: 0)

        let bottomViewCenterX = NSLayoutConstraint(item: contentView.subviews.last!,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)

        let topViewCenterY = NSLayoutConstraint(item: contentView.subviews.first!,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: contentView,
                                                attribute: .centerY,
                                                multiplier: 0.5,
                                                constant: 0)

        let bottomViewCenterY = NSLayoutConstraint(item: contentView.subviews.last!,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: contentView,
                                                   attribute: .centerY,
                                                   multiplier: 1.5,
                                                   constant: 0)

        let expectedConstraints = [topViewWidth, topViewHeight, topViewCenterX, topViewCenterY,
                                   bottomViewWidth, bottomViewHeight, bottomViewCenterX, bottomViewCenterY]

        contentView.constraints.map { $0.present(in: expectedConstraints) }
                               .forEach { XCTAssertTrue($0) }
    }
}
