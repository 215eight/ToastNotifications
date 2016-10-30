//
//  ViewAnimationTaskTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//
@testable import ToastNotifications
import XCTest

class MockViewAnimationTaskQueue: ViewAnimationTaskQueue {

    var animationDidFinishHandler: (() -> Void)?

    override func animationDidFinish(task: ViewAnimationTask) {
        super.animationDidFinish(task: task)
        animationDidFinishHandler?()
    }
}


class ViewAnimationTaskTests: XCTestCase {

    func testViewAnimationCanAnimate() {

        let animateExpectation = expectation(description: #function)

        let view = UIView()
        let viewAnimation = ViewAnimation(duration: 2.0,
                                          delay: 0.0,
                                          options: [],
                                          initialState: { view in
                                              animateExpectation.fulfill()
                                          },
                                          finalState: { view in
                                          })

        let task = ViewAnimationTask(view: view, animation: viewAnimation)
        task.animate()

        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(task.state, .animating)
        }
    }

    func testViewAnimationCanCancelAnimations() {

        let animateExpectation = expectation(description: #function)

        let view = UIView()
        let viewAnimation = ViewAnimation(duration: 0.0,
                                          delay: 0.0,
                                          options: [],
                                          initialState: { view in
                                              animateExpectation.fulfill()
                                          },
                                          finalState: { view in
                                          })

        let task = ViewAnimationTask(view: view, animation: viewAnimation)
        task.animate()
        task.cancel()

        waitForExpectations(timeout: 1.0) { (_) in
            XCTAssertEqual(task.state, .finished)
        }
    }

    func testViewAnimationTaskNotifiesAnimationFinished() {

        let expectation = self.expectation(description: #function)

        let fakeQueue = MockViewAnimationTaskQueue()
        fakeQueue.animationDidFinishHandler = {
            expectation.fulfill()
        }

        let task = ViewAnimationTask(view: UIView(), animation: ViewAnimation())
        fakeQueue.queue(task: task)
        fakeQueue.process()

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
