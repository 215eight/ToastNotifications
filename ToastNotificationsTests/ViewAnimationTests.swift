//
//  ViewAnimationTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
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
                    .initialState { (view) in
                        view.alpha = 0
                        initialAnimationExpectation.fulfill()
                    }
                    .finalState { (view) in
                        view.alpha = 1
                        finalAnimationExpectation.fulfill()
                    }

        let dummyView = UIView()

        test.initialState(dummyView)
        XCTAssertEqual(dummyView.alpha, 0)

        test.finalState(dummyView)
        XCTAssertEqual(dummyView.alpha, 1)

        waitForExpectationsWithTimeout(1, handler: nil)
    }
}
