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
