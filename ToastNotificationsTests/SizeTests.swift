//
//  SizeTests.swift
//  ToastNotifications
//
//  Created by pman215 on 11/24/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class SizeTests: XCTestCase {

    func testAbsoluteSize() {

        let superview = UIView(frame: CGRect.zero)
        superview.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        superview.addSubview(view)
        
        let size = Size(width: 200, height: 100)
        size.addSizeConstraints(to: view)

        superview.layoutIfNeeded()

        XCTAssertEqual(view.bounds.width, 200)
        XCTAssertEqual(view.bounds.height, 100)
    }

    func testRelativeSize() {

        let superview = UIView(frame: CGRect.zero)
        superview.translatesAutoresizingMaskIntoConstraints = false
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:[superview(100)]",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["superview" : superview])
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:[superview(100)]",
                                                        options: [],
                                                        metrics: nil,
                                                        views: ["superview" : superview])
        NSLayoutConstraint.activate(vertical)
        NSLayoutConstraint.activate(horizontal)


        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        superview.addSubview(view)

        let size = Size(xRatio: 0.5, yRatio: 0.5)
        size.addSizeConstraints(to: view)

        superview.layoutIfNeeded()

        XCTAssertEqual(view.bounds.width, 50)
        XCTAssertEqual(view.bounds.height, 50)
    }
}
