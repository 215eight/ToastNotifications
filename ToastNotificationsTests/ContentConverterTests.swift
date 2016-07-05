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

        let frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        let containerView = UIView(frame: frame)
        let content = Content(text: "Toast")

        let uiElements: ToastUIElements = convert(content, container: containerView)

        guard let toastView = uiElements.0.first else {
            XCTFail("No views found")
            return
        }

        let constraints = uiElements.1
        XCTAssertEqual(constraints.count, 4)

        let widthConstraint = NSLayoutConstraint(item: toastView,
                                                 attribute: .Width,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .Width,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(widthConstraint))

        let heightConstraint = NSLayoutConstraint(item: toastView,
                                                  attribute: .Height,
                                                  relatedBy: .Equal,
                                                  toItem: containerView,
                                                  attribute: .Height,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(heightConstraint))

        let centerXConstraint = NSLayoutConstraint(item: toastView,
                                                   attribute: .CenterX,
                                                   relatedBy: .Equal,
                                                   toItem: containerView,
                                                   attribute: .CenterX,
                                                   multiplier: 1,
                                                   constant: 0)
        XCTAssertTrue(constraints.contains(centerXConstraint))

        let centerYConstraint = NSLayoutConstraint(item: toastView,
                                                   
                                                   attribute: .CenterY,
                                                   relatedBy: .Equal,
                                                   toItem: containerView,
                                                   attribute: .CenterY,
                                                   multiplier: 1,
                                                   constant: 0)
        XCTAssertTrue(constraints.contains(centerYConstraint))
    }

    func testConvertContentBeside() {

        let frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        let containerView = UIView(frame: frame)
        let leftContent = Content(text: "Left")
        let rightContent = Content(text: "Right")

        let content = leftContent ||| rightContent

        let uiElements = convert(content, container: containerView)

        guard let leftView = uiElements.0.first,
              let rightView = uiElements.0.last else {
            XCTFail("No views found")
            return
        }

        let constraints = uiElements.1
        XCTAssertEqual(constraints.count, 8)

        let leftViewWidth = NSLayoutConstraint(item: leftView,
                                               attribute: .Width,
                                               relatedBy: .Equal,
                                               toItem: containerView,
                                               attribute: .Width,
                                               multiplier: 0.5,
                                               constant: 0)
        XCTAssertTrue(constraints.contains(leftViewWidth))

        let rightViewWidth = NSLayoutConstraint(item: rightView,
                                                attribute: .Width,
                                                relatedBy: .Equal,
                                                toItem: containerView,
                                                attribute: .Width,
                                                multiplier: 0.5,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(rightViewWidth))

        let leftViewHeight = NSLayoutConstraint(item: leftView,
                                                attribute: .Height,
                                                relatedBy: .Equal,
                                                toItem: containerView,
                                                attribute: .Height,
                                                multiplier: 1,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(leftViewHeight))

        let rightViewHeight = NSLayoutConstraint(item: rightView,
                                                 attribute: .Height,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .Height,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(rightViewHeight))

        let leftViewCenterX = NSLayoutConstraint(item: leftView,
                                                 attribute: .CenterX,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .CenterX,
                                                 multiplier: 0.5,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(leftViewCenterX))

        let rightViewCenterX = NSLayoutConstraint(item: rightView,
                                                  attribute: .CenterX,
                                                  relatedBy: .Equal,
                                                  toItem: containerView,
                                                  attribute: .CenterX,
                                                  multiplier: 1.5,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(rightViewCenterX))

        let leftViewCenterY = NSLayoutConstraint(item: leftView,
                                                 attribute: .CenterY,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .CenterY,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(leftViewCenterY))

        let rightViewCenterY = NSLayoutConstraint(item: rightView,
                                                  attribute: .CenterY,
                                                  relatedBy: .Equal,
                                                  toItem: containerView,
                                                  attribute: .CenterY,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(rightViewCenterY))

    }

    func testConvertContentStack() {

        let frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        let containerView = UIView(frame: frame)
        let topContent = Content(text: "Top")
        let bottomContent = Content(text: "Bottom")

        let content = topContent --- bottomContent

        let uiElements = convert(content, container: containerView)

        guard let topView = uiElements.0.first,
              let bottomView = uiElements.0.last else {
            XCTFail("No views found")
            return
        }

        let constraints = uiElements.1
        XCTAssertEqual(constraints.count, 8)

        let topViewWidth = NSLayoutConstraint(item: topView,
                                               attribute: .Width,
                                               relatedBy: .Equal,
                                               toItem: containerView,
                                               attribute: .Width,
                                               multiplier: 1,
                                               constant: 0)
        XCTAssertTrue(constraints.contains(topViewWidth))

        let bottomViewWidth = NSLayoutConstraint(item: bottomView,
                                                attribute: .Width,
                                                relatedBy: .Equal,
                                                toItem: containerView,
                                                attribute: .Width,
                                                multiplier: 1,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewWidth))

        let topViewHeight = NSLayoutConstraint(item: topView,
                                                attribute: .Height,
                                                relatedBy: .Equal,
                                                toItem: containerView,
                                                attribute: .Height,
                                                multiplier: 0.5,
                                                constant: 0)
        XCTAssertTrue(constraints.contains(topViewHeight))

        let bottomViewHeight = NSLayoutConstraint(item: bottomView,
                                                 attribute: .Height,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .Height,
                                                 multiplier: 0.5,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewHeight))

        let topViewCenterX = NSLayoutConstraint(item: topView,
                                                 attribute: .CenterX,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .CenterX,
                                                 multiplier: 1,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(topViewCenterX))

        let bottomViewCenterX = NSLayoutConstraint(item: bottomView,
                                                  attribute: .CenterX,
                                                  relatedBy: .Equal,
                                                  toItem: containerView,
                                                  attribute: .CenterX,
                                                  multiplier: 1,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewCenterX))

        let topViewCenterY = NSLayoutConstraint(item: topView,
                                                 attribute: .CenterY,
                                                 relatedBy: .Equal,
                                                 toItem: containerView,
                                                 attribute: .CenterY,
                                                 multiplier: 0.5,
                                                 constant: 0)
        XCTAssertTrue(constraints.contains(topViewCenterY))

        let bottomViewCenterY = NSLayoutConstraint(item: bottomView,
                                                  attribute: .CenterY,
                                                  relatedBy: .Equal,
                                                  toItem: containerView,
                                                  attribute: .CenterY,
                                                  multiplier: 1.5,
                                                  constant: 0)
        XCTAssertTrue(constraints.contains(bottomViewCenterY))
    }
}
