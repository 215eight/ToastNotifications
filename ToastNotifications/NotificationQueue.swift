//
//  NotificationQueue.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**

 List the states of a `NotificationQueue`

 + Idle: Queue is empty, waiting to process notifications
 + Processing: Processing a notification

 */
enum NotificationQueueState {
    case idle
    case processing
}

/**
 Data structure that describes the status of `NotificationQueue`

 + count: Number of notifications contained by the queue
 + state: Current state queue

 */
struct NotificationQueueStatus {
    let count: Int
    let state: NotificationQueueState
}

/**

 A `NotificationQueue` coordinates the order in which notifications are processed.
 The queue will process notifications in a FIFO serial order. Toasts can be added
 at any moment in time while the queue exists.

 Notification will be shown in the view controller specified when the queue was created

 */
@objc class NotificationQueue: NSObject {

    fileprivate var queue = [Notification]()
    fileprivate weak var presenter: NotificationPresenter?

    fileprivate var state: NotificationQueueState = .idle

    var status: NotificationQueueStatus {
        return NotificationQueueStatus(count: queue.count,
                                       state: state)
    }

    init(presenter: NotificationPresenter) {
        self.presenter = presenter
    }

    func queue(_ notification: Notification) {
        guard let presenter = presenter else {
            assertionFailure("Toast not queued due to lack of presenter to show it")
            return
        }
        
        notification.queue = self
        queue.append(notification)
        processFirstNotificationIfNeeded(in: presenter)
    }

    func dequeue(_ notification: Notification) {
        dequeueFirstNotification()

        guard let presenter = presenter else {
            assertionFailure("Processing failure due to lack of notification presenter")
            cancel()
            return
        }
        processFirstNotificationIfNeeded(in: presenter)
    }

    func cancel() {
        print("Cancelling...")
        if let currentNotification = queue.first {
            currentNotification.hide()
        }
        queue.removeAll()
        state = .idle
    }
}

private extension NotificationQueue {

    func shouldStartProcessing() -> Bool {
        return (state == .idle && queue.count > 0)
    }

    func processFirstNotificationIfNeeded(in presenter: NotificationPresenter) {

        if shouldStartProcessing(), let notification = queue.first {
            state = .processing
            notification.show(in: presenter)
        }
    }

    func dequeueFirstNotification() {
        let notification = queue.removeFirst()
        notification.queue = nil
        state = .idle
    }
}
