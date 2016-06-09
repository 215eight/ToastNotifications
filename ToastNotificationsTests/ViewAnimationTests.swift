//
//  ViewAnimationTests.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ViewAnimationTests: XCTestCase {

    func testViewAnimation() {

        let test = ViewAnimation()

        XCTAssertEqual(test.duration, 0)
        XCTAssertEqual(test.delay, 0)
        XCTAssertTrue(test.options == .LayoutSubviews)
    }

    func testViewAnimationComposition() {

        let test = ViewAnimation()
                    .duration(2)
                    .delay(1)
                    .options([.LayoutSubviews, .AllowUserInteraction])

        XCTAssertEqual(test.duration, 2)
        XCTAssertEqual(test.delay, 1)
        XCTAssertTrue(test.options == [.LayoutSubviews, .AllowUserInteraction])
    }

    func testViewAnimationState() {

        let initialAnimationExpectation = expectationWithDescription("InitialStateExpectation")
        let finalAnimationExpectation = expectationWithDescription("FinalStateExpection")

        let test = ViewAnimation()
                    .duration(2)
                    .initialAnimation { (view) in
                        view.alpha = 0
                        initialAnimationExpectation.fulfill()
                    }
                    .finalAnimation { (view) in
                        view.alpha = 1
                        finalAnimationExpectation.fulfill()
                    }

        let dummyView = UIView()

        test.initialAnimation(dummyView)
        XCTAssertEqual(dummyView.alpha, 0)

        test.finalAnimation(dummyView)
        XCTAssertEqual(dummyView.alpha, 1)

        waitForExpectationsWithTimeout(1, handler: nil)
    }
}
