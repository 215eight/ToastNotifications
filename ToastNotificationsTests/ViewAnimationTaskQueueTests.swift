//
//  ViewAnimationTaskQueueTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

fileprivate extension ViewAnimationTask {

    convenience init() {
        self.init(view: UIView(),
                  animation: ViewAnimation())
    }
}

class ViewAnimationTaskQueueTests: XCTestCase {

    func testQueueInitialState() {

        let queue = ViewAnimationTaskQueue()

        XCTAssertEqual(queue.state, .new)
        XCTAssertEqual(queue.tasks.count, 0)
    }

    func testQueueTaskWithoutProcessing() {

        let view = UIView()
        let task1 = ViewAnimationTask(view: view, animation: ViewAnimation())
        let task2 = ViewAnimationTask(view: view, animation: ViewAnimation())

        let queue = ViewAnimationTaskQueue()
        queue.queue(task: task1)
        queue.queue(task: task2)

        XCTAssertEqual(queue.state, .new)
        XCTAssertEqual(queue.tasks.count, 2)
    }

    func testQueueCanProcess() {

        let task1 = ViewAnimationTask()
        let task2 = ViewAnimationTask()

        let queue = ViewAnimationTaskQueue()
        queue.queue(task: task1)
        queue.queue(task: task2)

        queue.process()

        XCTAssertTrue(queue.state == .processing)
        XCTAssertEqual(queue.tasks.count, 2)
        XCTAssertTrue(task1.state == .animating)

        // Simulate animation did finish
        queue.animationDidFinish(task: task1)

        XCTAssertEqual(queue.state, .processing)
        XCTAssertEqual(queue.tasks.count, 1)
        XCTAssertTrue(task2.state == .animating)

        // Simulate animation did finish
        queue.animationDidFinish(task: task2)

        XCTAssertEqual(queue.state, .finished)
        XCTAssertEqual(queue.tasks.count, 0)
    }

    func testQueueFinishesImmediatelyWithoutTasks() {

        let queue = ViewAnimationTaskQueue()
        queue.process()
        XCTAssertEqual(queue.state, .finished)
    }

    func testQueueCancelWhileProcessing() {

        let task1 = ViewAnimationTask()
        let task2 = ViewAnimationTask()

        let queue = ViewAnimationTaskQueue()
        queue.queue(task: task1)
        queue.queue(task: task2)

        queue.process()
        queue.cancel()

        XCTAssertEqual(queue.state, .finished)
        XCTAssertTrue(queue.tasks.isEmpty)
        XCTAssertEqual(task1.state, .finished)
        XCTAssertEqual(task2.state, .finished)
    }

    func testQueueCanCancelBeforeStartProcessing() {

        let task1 = ViewAnimationTask()
        let task2 = ViewAnimationTask()

        let queue = ViewAnimationTaskQueue()
        queue.queue(task: task1)
        queue.queue(task: task2)

        queue.cancel()

        XCTAssertEqual(queue.state, .finished)
        XCTAssertTrue(queue.tasks.isEmpty)
        XCTAssertEqual(task1.state, .finished)
        XCTAssertEqual(task2.state, .finished)
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

        let task1 = ViewAnimationTask()
        let task2 = ViewAnimationTask()

        let queue = ViewAnimationTaskQueue()
        queue.delegate = delegate
        queue.queue(task: task1)
        queue.queue(task: task2)

        queue.process()

        waitForExpectations(timeout: 1.0) { (_) in

            XCTAssertEqual(queue.tasks.count, 0)
            XCTAssertEqual(queue.state, .finished)
            XCTAssertEqual(task1.state, .finished)
            XCTAssertEqual(task2.state, .finished)
        }

    }
}
