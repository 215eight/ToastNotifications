//
//  ViewAnimationTaskTests.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//
@testable import ToastNotifications
import XCTest

class MockViewAnimationTaskQueue: ViewAnimationTaskQueue {

    var animationDidFinishHandler: (() -> Void)?

    override func animationDidFinish(task: ViewAnimationTask) {
        super.animationDidFinish(task)
        animationDidFinishHandler?()
    }
}


class ViewAnimationTaskTests: XCTestCase {

    func testViewAnimationTaskNotifiesAnimationFinished() {

        let expectation = expectationWithDescription(#function)

        let fakeQueue = MockViewAnimationTaskQueue()
        fakeQueue.animationDidFinishHandler = {
            expectation.fulfill()
        }

        let task = ViewAnimationTask(view: UIView(), animation: ViewAnimation())
        fakeQueue.queue(task)
        fakeQueue.process()

        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
}
