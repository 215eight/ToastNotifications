//
//  ViewAnimationTaskQueue.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

enum ViewAnimationTaskQueueState {
    case New
    case Processing
    case Idle
    case Finished
}

protocol ViewAnimationTaskQueueDelegate: class {

    func queueDidFinishProcessing(queue: ViewAnimationTaskQueue)
}

class ViewAnimationTaskQueue {

    private var queue = [ViewAnimationTask]()

    private (set) var state: ViewAnimationTaskQueueState = .New {

        willSet {

            switch (state, newValue) {
            case (.New, .Processing):
                break
            case (.Idle, .Processing):
                break
            case (.Processing, .Idle):
                break
            case (.Idle, .Finished):
                break
            case (.New, .Finished):
                break
            case (.New, .New),
                 (.Idle, .Idle),
                 (.Processing, .Processing),
                 (.Finished, .Finished):
                fatalError("Invalid state transition \(state) -> \(newValue)")
            default:
                fatalError("Invalid state transition \(state) -> \(newValue)")
            }
        }

        didSet {

            switch state {
            case .Finished:
                delegate?.queueDidFinishProcessing(self)
            default:
                break
            }
        }
    }

    var tasks: [ViewAnimationTask] {
        return queue
    }

    weak var delegate: ViewAnimationTaskQueueDelegate?

    func queue(animationTask: ViewAnimationTask) {
        animationTask.queue = self
        queue.append(animationTask)
    }

    func process() -> Bool {
        if canStart() {
            processFirstAnimation()
            return true
        }
        return false
    }

    func animationDidFinish(task: ViewAnimationTask) {
        dequeueFirstAnimation(task)
        processFirstAnimation()
    }
}

private extension ViewAnimationTaskQueue {


    func canStart() -> Bool {
        return state == .New
    }

    func canProcess() -> Bool {
        return queue.count > 0 && (state == .New || state == .Idle)
    }

    func didFinish() -> Bool {
        return queue.count == 0 && (state == .New || state == .Idle)
    }

    func processFirstAnimation() {

        if canProcess(), let first = queue.first {
            state = .Processing
            first.animate()
        } else if didFinish() {
            state = .Finished
        }
    }

    func dequeueFirstAnimation(task: ViewAnimationTask) {

        if let _task = queue.first where _task === task {
            let dequeueTask = queue.removeFirst()
            dequeueTask.queue = nil
            state = .Idle
        } else {
            assertionFailure("Trying to dequeue unrecognized task \(task)")
        }
    }
}

