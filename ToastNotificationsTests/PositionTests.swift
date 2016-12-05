//
//  PositionTests.swift
//  ToastNotifications
//
//  Created by pman215 on 11/26/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class PositionTests: XCTestCase {

    var superview: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()
        setSuperview()
        setView()
    }

    override func tearDown() {
        superview = nil
        view = nil
        super.tearDown()
    }

    func testTopPosition() {
        let position = Position.top(offset: 0)
        position.addPositionConstraints(to: view)

        superview.layoutIfNeeded()
        superview.frame.origin = CGPoint(x: 0, y: 0)

        XCTAssertEqual(view.frame.midX, 50)
        XCTAssertEqual(view.frame.minY, 0)
    }

    func testCenterPosition() {
        let position = Position.center
        position.addPositionConstraints(to: view)

        superview.layoutIfNeeded()
        superview.frame.origin = CGPoint(x: 0, y: 0)

        XCTAssertEqual(view.frame.midX, 50)
        XCTAssertEqual(view.frame.midY, 50)
    }

    func testBottomPosition() {
        let position = Position.bottom(offset: 0)
        position.addPositionConstraints(to: view)

        superview.layoutIfNeeded()
        superview.frame.origin = CGPoint(x: 0, y: 0)

        XCTAssertEqual(view.frame.midX, 50)
        XCTAssertEqual(view.frame.maxY, 100)
    }
}

private extension PositionTests {

    func setSuperview() {
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

        self.superview = superview
    }

    func setView() {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:[view(50)]",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["view" : view])
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:[view(50)]",
                                                        options: [],
                                                        metrics: nil,
                                                        views: ["view" : view])
        NSLayoutConstraint.activate(vertical)
        NSLayoutConstraint.activate(horizontal)

        superview.addSubview(view)

        self.view = view
    }
}
