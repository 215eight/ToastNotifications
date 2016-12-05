//
//  NotificationQueueTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

final class StubNotificationPresenter: NotificationPresenter {

    func show(notification: ToastNotifications.Notification) {
        // Do nothing
    }

    func hideNotifications() {
        // Do nothing
    }
}

final class NotificationQueueTests: XCTestCase {

    func testQueueCreation() {

        let view = UIView()
        let queue = NotificationQueue(presenter: view)

        XCTAssertTrue(queue.status.state == .idle)
    }

    func testQueueCanQueueNotifications() {

        let view = UIView()
        let queue = NotificationQueue(presenter: view)
        queue.queue(Notification(text: "CanQueue"))

        XCTAssertTrue(queue.status.state == .processing,
                      "Expected: Processing. Actual: \(queue.status.state)")
    }

    func testQueueCanCancelNotifications() {
        let view = UIView()
        let queue = NotificationQueue(presenter: view)
        queue.queue(Notification(text: "Toast1"))
        queue.queue(Notification(text: "Toast2"))
        queue.cancel()
        XCTAssertTrue(queue.status.state == .idle,
                      "Expected: Idle. Actual: \(queue.status.state)")

    }

    func testQueueFIFOAutomaticNotificationProcessing() {

        let notification1 = Notification(text: "QueueFIFO1")
        let notification2 = Notification(text: "QueueFIFO2")

        let stubNotificationPresenter = StubNotificationPresenter()
        let queue = NotificationQueue(presenter: stubNotificationPresenter)

        queue.queue(notification1)
        queue.queue(notification2)

        XCTAssertEqual(queue.status.count, 2)
        XCTAssertTrue(queue.status.state == .processing)

        notification1.didShow()
        notification1.hide()
        notification1.didHide()

        XCTAssertEqual(queue.status.count, 1)
        XCTAssertTrue(queue.status.state == .processing)

        notification2.didShow()
        notification2.hide()
        notification2.didHide()

        XCTAssertEqual(queue.status.count, 0)
        XCTAssertTrue(queue.status.state == .idle)
    }
}
