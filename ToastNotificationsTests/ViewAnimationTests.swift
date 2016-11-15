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
        XCTAssertTrue(test.options == .beginFromCurrentState)
    }

    func testViewAnimationComposition() {

        let test = ViewAnimation().duration(2)
                                  .delay(1)
                                  .options([.beginFromCurrentState])

        XCTAssertEqual(test.duration, 2)
        XCTAssertEqual(test.delay, 1)
        XCTAssertTrue(test.options == [.beginFromCurrentState])
    }

    func testViewAnimationState() {

        let initialAnimationExpectation = expectation(description: "InitialStateExpectation")
        let finalAnimationExpectation = expectation(description: "FinalStateExpection")

        let test = ViewAnimation().duration(2)
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

        waitForExpectations(timeout: 1, handler: nil)
    }
}
