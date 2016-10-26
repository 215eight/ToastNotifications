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
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: view2,
                                           attribute: .width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view1,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertEqual(constraint1, constraint2)
    }

    func testNonEqualItemConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: view2,
                                           attribute: .width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view3,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertNotEqual(constraint1, constraint2)
    }

    func testNonEqualAttributeConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .height,
                                           relatedBy: .equal,
                                           toItem: view2,
                                           attribute: .width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertNotEqual(constraint1, constraint2)
    }

    func testNonEqualRelatedByConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .width,
                                           relatedBy: .greaterThanOrEqual,
                                           toItem: view2,
                                           attribute: .width,
                                           multiplier: 1,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertNotEqual(constraint1, constraint2)
    }

    func testNonEqualMultiplyConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: view2,
                                           attribute: .width,
                                           multiplier: 1.5,
                                           constant: 0)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertNotEqual(constraint1, constraint2)
    }

    func testNonEqualConstantConstraints() {

        let constraint1 = NSLayoutConstraint(item: view1,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: view2,
                                           attribute: .width,
                                           multiplier: 1,
                                           constant: 10)

        let constraint2 = NSLayoutConstraint(item: view2,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: 0)

        XCTAssertNotEqual(constraint1, constraint2)
    }

    func testFindEqualConstraintInArray() {

        let expectedConstraint = NSLayoutConstraint(item: view1,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: view2,
                                                    attribute: .width,
                                                    multiplier: 1,
                                                    constant: 0)

        let constraint1 = NSLayoutConstraint(item: view1,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: view2,
                                             attribute: .width,
                                             multiplier: 1,
                                             constant: 0)

        let constraint2 = NSLayoutConstraint(item: view1,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: view3,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: 0)

        let constraints = [constraint1, constraint2]

        XCTAssertTrue(constraints.contains(expectedConstraint))
    }
}
