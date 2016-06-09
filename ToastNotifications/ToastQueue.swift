//
//  ToastQueue.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit


enum ToastQueueState {
    case Idle
    case Processing
}

struct ToastQueueStatus {
    let toastCount: Int
    let state: ToastQueueState
}

@objc class ToastQueue: NSObject {

    private var queue = [Toast]()
    private var viewController: UIViewController

    private var state: ToastQueueState = .Idle {

        willSet(newState) {
            switch (state, newState) {
            case (.Idle, .Processing) where shouldStartProcessing():
                break
            case (.Processing, .Idle):
                break
            case (.Idle, .Idle), (.Processing, .Processing):
                fatalError("Invalid state transition \(state) -> \(newState)")
            default:
                fatalError("Invalid state transition \(state) -> \(newState)")
            }
        }
    }

    var status: ToastQueueStatus {
        return ToastQueueStatus(toastCount: queue.count,
                                state: state)
    }

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func queue(toast: Toast) {
        toast.queue = self
        queue.append(toast)
        processFirstToast()
    }
}

private extension ToastQueue {

    func shouldStartProcessing() -> Bool {
        return (state == .Idle && queue.count > 0)
    }

    func processFirstToast() {

        if shouldStartProcessing(), let toast = queue.first {
            state = .Processing
            show(toast, inViewController: viewController)
        }
    }

    func dequeueFirstToast() {
        let first = queue.removeFirst()
        first.queue = nil
        state = .Idle
    }
}

extension ToastQueue {

    func toastDidShow(toast: Toast) {
        dequeueFirstToast()
        processFirstToast()
    }
}
