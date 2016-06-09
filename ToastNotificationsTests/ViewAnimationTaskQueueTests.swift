//
//  ViewAnimationTaskQueueTests.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/7/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class FakeViewAnimationTask: ViewAnimationTask {

    init() {
        super.init(view: UIView(), animation: ViewAnimation())
    }

    override func animate() {
        state = .Animating
    }
}

class ViewAnimationTaskQueueTests: XCTestCase {

    func testQueueInitialState() {

        let queue = ViewAnimationTaskQueue()

        XCTAssertTrue(queue.state == .New)
        XCTAssertEqual(queue.tasks.count, 0)
    }

    func testQueueTaskWithoutProcessing() {

        let view = UIView()
        let task1 = ViewAnimationTask(view: view, animation: ViewAnimation())
        let task2 = ViewAnimationTask(view: view, animation: ViewAnimation())

        let queue = ViewAnimationTaskQueue()
        queue.queue(task1)
        queue.queue(task2)

        XCTAssertTrue(queue.state == .New)
        XCTAssertEqual(queue.tasks.count, 2)
    }

    func testQueueCanProcess() {

        let task1 = FakeViewAnimationTask()
        let task2 = FakeViewAnimationTask()

        let queue = ViewAnimationTaskQueue()
        queue.queue(task1)
        queue.queue(task2)

        queue.process()

        XCTAssertTrue(queue.state == .Processing)
        XCTAssertEqual(queue.tasks.count, 2)
        XCTAssertTrue(task1.state == .Animating)

        // Simulate animation did finish
        task1.state = .Finished

        XCTAssertTrue(queue.state == .Processing)
        XCTAssertEqual(queue.tasks.count, 1)
        XCTAssertTrue(task2.state == .Animating)

        task2.state = .Finished

        XCTAssertTrue(queue.state == .Finished)
        XCTAssertEqual(queue.tasks.count, 0)
    }

    func testQueueFinishesImmediatelyWithoutTasks() {

        let queue = ViewAnimationTaskQueue()
        queue.process()

        XCTAssertTrue(queue.state == .Finished)
    }

    func testQueueOnlyProccessTasksOnce() {

        let queue = ViewAnimationTaskQueue()
        XCTAssertTrue(queue.process())
        XCTAssertFalse(queue.process())
        XCTAssertFalse(queue.process())
    }

    func testQueueNotifiesDelegateDidFinishProcessing() {


        class TestDelegate: ViewAnimationTaskQueueDelegate {

            var queueDidFinishProcessingHandler: (()-> Void)?
            func queueDidFinishProcessing(queue: ViewAnimationTaskQueue) {
                queueDidFinishProcessingHandler?()
            }
        }

        let expectation = expectationWithDescription(#function)

        let delegate = TestDelegate()
        delegate.queueDidFinishProcessingHandler = {
            expectation.fulfill()
        }

        let view = UIView()
        let task1 = ViewAnimationTask(view: view, animation: ViewAnimation())
        let task2 = ViewAnimationTask(view: view, animation: ViewAnimation())

        let queue = ViewAnimationTaskQueue()
        queue.delegate = delegate
        queue.queue(task1)
        queue.queue(task2)

        queue.process()

        waitForExpectationsWithTimeout(1.0) { (_) in

            XCTAssertEqual(queue.tasks.count, 0)
            XCTAssertTrue(queue.state == .Finished)
            XCTAssertTrue(task1.state == .Finished)
            XCTAssertTrue(task2.state == .Finished)
        }

    }
}
