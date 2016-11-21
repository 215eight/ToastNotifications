//
//  ToastQueue.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**

 List the states of a `ToastQueue`

 + Idle: Queue is empty, waiting to process toasts
 + Processing: Processing a toast

 */
enum ToastQueueState {
    case idle
    case processing
}

/**
 Data structure that describes the status of `ToastQueue`

 + toastCount: Number of toast contained by the queue
 + state: Current state queue

 */
struct ToastQueueStatus {
    let toastCount: Int
    let state: ToastQueueState
}

/**

 A `ToastQueue` coordinates the order in which toasts are processed. The queue
 will process toasts in a FIFO serial order. Toasts can be added at any moment
 in time while the queue exists.

 Toast will be shown in the view controller specified when the queue was created

 */
@objc class ToastQueue: NSObject {

    fileprivate var queue = [Toast]()
    fileprivate var presenter: ToastPresenter

    fileprivate var state: ToastQueueState = .idle {
        willSet(newState) {

            switch (state, newState) {
                
            case (.idle, .processing) where shouldStartProcessing():
                break
                
            case (.processing, .idle):
                break
            case (.idle, _),
                 (.processing, _):
                fatalError("Invalid state transition \(state) -> \(newState)")
            }
        }
    }

    var status: ToastQueueStatus {
        return ToastQueueStatus(toastCount: queue.count,
                                state: state)
    }

    init(presenter: ToastPresenter) {
        self.presenter = presenter
    }

    func queue(_ toast: Toast) {
        toast.queue = self
        queue.append(toast)
        processFirstToastIfNeeded()
    }

    func dequeue(_ toast: Toast) {
        dequeueFirstToast()
        processFirstToastIfNeeded()
    }

    func cancel() {
        print("Cancelling...")
        if let currentToast = queue.first {
            currentToast.hide()
        }
        queue.removeAll()
    }
}

private extension ToastQueue {

    func shouldStartProcessing() -> Bool {
        return (state == .idle && queue.count > 0)
    }

    func processFirstToastIfNeeded() {

        if shouldStartProcessing(), let toast = queue.first {
            state = .processing
            toast.show(in: presenter)
        }
    }

    func dequeueFirstToast() {
        let first = queue.removeFirst()
        first.queue = nil
        state = .idle
    }
}
