//
//  ToastQueueTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class StubToastPresenter: ToastPresenter {

    func show(toast: Toast) {
        // Do nothing
        toast.willShow()
        toast.didShow()
    }

    func hide(toast: Toast) {
        // Do nothing
        toast.willHide()
        toast.didHide()
    }
}

class ToastQueueTests: XCTestCase {

    func testQueueCreation() {

        let viewController = UIViewController()
        let queue = ToastQueue(presenter: viewController.view)

        XCTAssertTrue(queue.status.state == .idle)
    }

    func testQueueCanQueueToasts() {

        let viewController = UIViewController()
        let _ = viewController.view
        let queue = ToastQueue(presenter: viewController.view)
        queue.queue(Toast(text: "CanQueue"))

        XCTAssertTrue(queue.status.state == .processing, "Expected: Processing. Actual: \(queue.status.state)")
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

        toast1.hide()

        XCTAssertEqual(queue.status.toastCount, 1)
        XCTAssertTrue(queue.status.state == .processing)

        toast2.hide()

        XCTAssertEqual(queue.status.toastCount, 0)
        XCTAssertTrue(queue.status.state == .idle)

    }
}
