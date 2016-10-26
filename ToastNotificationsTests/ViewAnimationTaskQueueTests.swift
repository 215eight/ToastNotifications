//
//  ViewAnimationTaskQueueTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class FakeViewAnimationTask: ViewAnimationTask {

    init() {
        super.init(view: UIView(), animation: ViewAnimation())
    }

    override func animate() {
        state = .animating
    }
}

class ViewAnimationTaskQueueTests: XCTestCase {

    func testQueueInitialState() {

        let queue = ViewAnimationTaskQueue()

        XCTAssertTrue(queue.state == .new)
        XCTAssertEqual(queue.tasks.count, 0)
    }

    func testQueueTaskWithoutProcessing() {

        let view = UIView()
        let task1 = ViewAnimationTask(view: view, animation: ViewAnimation())
        let task2 = ViewAnimationTask(view: view, animation: ViewAnimation())

        let queue = ViewAnimationTaskQueue()
        queue.queue(task: task1)
        queue.queue(task: task2)

        XCTAssertTrue(queue.state == .new)
        XCTAssertEqual(queue.tasks.count, 2)
    }

    func testQueueCanProcess() {

        let task1 = FakeViewAnimationTask()
        let task2 = FakeViewAnimationTask()

        let queue = ViewAnimationTaskQueue()
        queue.queue(task: task1)
        queue.queue(task: task2)

        _ = queue.process()

        XCTAssertTrue(queue.state == .processing)
        XCTAssertEqual(queue.tasks.count, 2)
        XCTAssertTrue(task1.state == .animating)

        // Simulate animation did finish
        task1.state = .finished

        XCTAssertTrue(queue.state == .processing)
        XCTAssertEqual(queue.tasks.count, 1)
        XCTAssertTrue(task2.state == .animating)

        task2.state = .finished

        XCTAssertTrue(queue.state == .finished)
        XCTAssertEqual(queue.tasks.count, 0)
    }

    func testQueueFinishesImmediatelyWithoutTasks() {

        let queue = ViewAnimationTaskQueue()
        _ = queue.process()

        XCTAssertTrue(queue.state == .finished)
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

            func queueDidFinishProcessing(_ queue: ViewAnimationTaskQueue) {
                queueDidFinishProcessingHandler?()
            }
        }

        let expectation = self.expectation(description: #function)

        let delegate = TestDelegate()
        delegate.queueDidFinishProcessingHandler = {
            expectation.fulfill()
        }

        let view = UIView()
        let task1 = ViewAnimationTask(view: view, animation: ViewAnimation())
        let task2 = ViewAnimationTask(view: view, animation: ViewAnimation())

        let queue = ViewAnimationTaskQueue()
        queue.delegate = delegate
        queue.queue(task: task1)
        queue.queue(task: task2)

        _ = queue.process()

        waitForExpectations(timeout: 1.0) { (_) in

            XCTAssertEqual(queue.tasks.count, 0)
            XCTAssertTrue(queue.state == .finished)
            XCTAssertTrue(task1.state == .finished)
            XCTAssertTrue(task2.state == .finished)
        }

    }
}
