//
//  NSLayoutConstraintExtensionTests.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 7/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest


class NSLayoutConstraintExtensionTests: XCTestCase {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()

    func testEqualConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .Width,
                                           relatedBy: .Equal,
                                           toItem: view2,
                                           attribute: .Width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view1,
                                            attribute: .Width,
                                            relatedBy: .Equal,
                                            toItem: view2,
                                            attribute: .Width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertTrue(constraint1 == constraint2)
    }

    func testNonEqualItemConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .Width,
                                           relatedBy: .Equal,
                                           toItem: view2,
                                           attribute: .Width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view3,
                                            attribute: .Width,
                                            relatedBy: .Equal,
                                            toItem: view2,
                                            attribute: .Width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertTrue(constraint1 != constraint2)
    }

    func testNonEqualAttributeConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .Height,
                                           relatedBy: .Equal,
                                           toItem: view2,
                                           attribute: .Width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .Width,
                                            relatedBy: .Equal,
                                            toItem: view2,
                                            attribute: .Width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertTrue(constraint1 != constraint2)
    }

    func testNonEqualRelatedByConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .Width,
                                           relatedBy: .GreaterThanOrEqual,
                                           toItem: view2,
                                           attribute: .Width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .Width,
                                            relatedBy: .Equal,
                                            toItem: view2,
                                            attribute: .Width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertTrue(constraint1 != constraint2)
    }

    func testNonEqualMultiplyConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .Width,
                                           relatedBy: .Equal,
                                           toItem: view2,
                                           attribute: .Width,
                                           multiplier: 1.5,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .Width,
                                            relatedBy: .Equal,
                                            toItem: view2,
                                            attribute: .Width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertTrue(constraint1 != constraint2)
    }

    func testNonEqualConstantConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .Width,
                                           relatedBy: .Equal,
                                           toItem: view2,
                                           attribute: .Width,
                                           multiplier: 1,
                                           constant: 10)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .Width,
                                            relatedBy: .Equal,
                                            toItem: view2,
                                            attribute: .Width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertTrue(constraint1 != constraint2)
    }
}
