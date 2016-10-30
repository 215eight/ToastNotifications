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
    case new
    case processing
    case idle
    case finished
}

/**
 Interface that defines the communication messages sent between the queue and
 its delegate
 */
internal protocol ViewAnimationTaskQueueDelegate: class {

    /**
     Called when a `ViewAnimationTaskQueue` finished processing all queued tasks
     */
    func queueDidFinishProcessing(_ queue: ViewAnimationTaskQueue)
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

    fileprivate var queue = [ViewAnimationTask]()

    fileprivate (set) var state: ViewAnimationTaskQueueState {
        willSet {
            switch (state, newValue) {

            case (.new, .new):
                break

            case (.new, .processing):
                break

            case (.new, .idle):
                break

            case (.new, .finished):
                break

            case (.processing, .new):
                break

            case (.processing, .processing):
                break

            case (.processing, .idle):
                break

            case (.processing, .finished):
                break

            case (.idle, .new):
                break

            case (.idle, .processing):
                break

            case (.idle, .idle):
                break

            case (.idle, .finished):
                break

             case (.finished, .new):
                break

            case (.finished, .processing):
                break

            case (.finished, .idle):
                break

            case (.finished, .finished):
                break
            }
        }

        didSet {

            switch state {
            case .finished:
                delegate?.queueDidFinishProcessing(self)
            case .new, .processing, .idle:
                break
            }
        }
    }

    var tasks: [ViewAnimationTask] {
        return queue
    }

    weak var delegate: ViewAnimationTaskQueueDelegate?

    init() {
        state = .new
    }

    func queue(task: ViewAnimationTask) {
        task.queue = self
        queue.append(task)
    }

    func process() -> Bool {
        if canStart() {
            processFirstAnimationIfNeeded()
            return true
        }
        return false
    }

    func cancel() {
        queue.forEach {
            $0.cancel()
        }
        queue.removeAll()
        state = .finished
    }

    func animationDidFinish(task: ViewAnimationTask) {
        dequeueFirstAnimation(task)
        processFirstAnimationIfNeeded()
    }
}

private extension ViewAnimationTaskQueue {

    func canStart() -> Bool {
        return state == .new
    }

    func canProcess() -> Bool {
        return queue.count > 0 && (state == .new || state == .idle)
    }

    func didFinish() -> Bool {
        return queue.count == 0 && (state == .new || state == .idle)
    }

    func processFirstAnimationIfNeeded() {

        if canProcess(), let viewAnimationTask = queue.first {
            state = .processing
            viewAnimationTask.animate()
        } else if didFinish() {
            state = .finished
        }
    }

    func dequeueFirstAnimation(_ task: ViewAnimationTask) {

        if let _task = queue.first , _task === task {
            let dequeueTask = queue.removeFirst()
            dequeueTask.queue = nil
            state = .idle
        } else {
//            assertionFailure("Trying to dequeue unrecognized task \(task)")
        }
    }
}
