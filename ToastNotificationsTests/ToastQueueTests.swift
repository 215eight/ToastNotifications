//
//  ToastQueueTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

final class StubToastPresenter: ToastPresenter {

    func show(toast: Toast) {
        // Do nothing
    }

    func hideToasts() {
        // Do nothing
    }
}

final class ToastQueueTests: XCTestCase {

    func testQueueCreation() {

        let view = UIView()
        let queue = ToastQueue(presenter: view)

        XCTAssertTrue(queue.status.state == .idle)
    }

    func testQueueCanQueueToasts() {

        let view = UIView()
        let queue = ToastQueue(presenter: view)
        queue.queue(Toast(text: "CanQueue"))

        XCTAssertTrue(queue.status.state == .processing,
                      "Expected: Processing. Actual: \(queue.status.state)")
    }

    func testQueueFIFOAutomaticToastProcessing() {

        let toast1 = Toast(text: "QueueFIFO1")
        let toast2 = Toast(text: "QueueFIFO2")

        let stubToastPresenter = StubToastPresenter()
        let queue = ToastQueue(presenter: stubToastPresenter)

        queue.queue(toast1)
        queue.queue(toast2)

        XCTAssertEqual(queue.status.toastCount, 2)
        XCTAssertTrue(queue.status.state == .processing)

        toast1.didShow()
        toast1.hide()
        toast1.didHide()

        XCTAssertEqual(queue.status.toastCount, 1)
        XCTAssertTrue(queue.status.state == .processing)

        toast2.didShow()
        toast2.hide()
        toast2.didHide()

        XCTAssertEqual(queue.status.toastCount, 0)
        XCTAssertTrue(queue.status.state == .idle)
    }
}
