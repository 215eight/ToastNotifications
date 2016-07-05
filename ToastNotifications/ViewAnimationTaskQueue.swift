//
//  ViewAnimationTaskQueue.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**

 Describes the possible states of a `ViewAnimationTaskQueue`

 + New: Queue was initialized and is ready to queue tasks and start processing
 them

 + Processing: Queue started processing tasks. Queueing more tasks is not
 allowed

 + Idle: Queue just processed a task. Waiting to process additional
 tasks if exist or to finish execution

 + Finished: Queue processed all tasks in the queue.

 */

internal enum ViewAnimationTaskQueueState {
    case New
    case Processing
    case Idle
    case Finished
}

/**
 Interface that defines the communication messages sent between the queue and
 its delegate
 */
internal protocol ViewAnimationTaskQueueDelegate: class {

    /**
     Called when a `ViewAnimationTaskQueue` finished processing all queued tasks
     */
    func queueDidFinishProcessing(queue: ViewAnimationTaskQueue)
}

/**
 A `ViewAnimationTaskQueue` coordinates the execution of `ViewAnimationTask`
 objects. When a task is added to the queue it will start execution immediately
 as long as there are no other task being processed. Tasks are processed in a
 FIFO serial order

 When a `ViewAnimationTaskQueue` object is initialized, all tasks intended for
 processing should be added. Once the queue starts processing, by colling its
 `process()`, no more tasks can be queued.

 A queue is a single-shot object, once it has finished processing all its tasks,
 the queue should be disposed.
 */
internal class ViewAnimationTaskQueue {

    private var queue = [ViewAnimationTask]()

    private (set) var state: ViewAnimationTaskQueueState = .New {

        willSet {

            switch (state, newValue) {
            case (.New, .Processing),
                 (.Idle, .Processing),
                 (.Processing, .Idle),
                 (.Idle, .Finished),
                 (.New, .Finished):
                break
            case (.New, _),
                 (.Idle, _),
                 (.Processing, _),
                 (.Finished, _):
                let message = "Invalid state transition \(state) -> \(newValue)"
                assertionFailure(message)
            }
        }

        didSet {

            switch state {
            case .Finished:
                delegate?.queueDidFinishProcessing(self)
            case .New, .Processing, .Idle:
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
