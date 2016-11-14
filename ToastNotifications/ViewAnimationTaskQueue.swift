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

 + Finished: Queue processed all tasks in the queue.

 */

internal enum ViewAnimationTaskQueueState {
    case new
    case processing
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
                invalidTransition(from: .new, to: .new)

            case (.new, .processing):
                processTasks()

            case (.new, .finished):
                cancelAllTasks()

            case (.processing, .new):
                invalidTransition(from: .processing, to: .new)

            case (.processing, .processing):
                invalidTransition(from: .processing, to: .processing)

            case (.processing, .finished):
                cancelAllTasks()

            case (.finished, .new):
                invalidTransition(from: .finished, to: .new)

            case (.finished, .processing):
                invalidTransition(from: .finished, to: .processing)

            case (.finished, .finished):
                invalidTransition(from: .processing, to: .processing)
            }
        }

        didSet {

            switch (oldValue, state) {

            case (.new, .new):
                invalidTransition(from: .new, to: .new)

            case (.new, .processing):
                break

            case (.new, .finished):
                break

            case (.processing, .new):
                invalidTransition(from: .processing, to: .new)

            case (.processing, .processing):
                invalidTransition(from: .processing, to: .processing)

            case (.processing, .finished):
                if queue.isEmpty {
                    delegate?.queueDidFinishProcessing(self)
                }

            case (.finished, .new):
                invalidTransition(from: .finished, to: .new)

            case (.finished, .processing):
                invalidTransition(from: .finished, to: .new)

            case (.finished, .finished):
                invalidTransition(from: .finished, to: .new)
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

    func process() {
        if queue.isEmpty {
            print("WARNING: ViewAnimationTaskQueue processing but queue is empty")
            state = .finished
        } else {
            state = .processing
        }
    }

    func cancel() {
        cancelAllTasks()
    }

    func animationDidFinish(task: ViewAnimationTask) {
        dequeueFirstAnimation(task)
        processTasks()
    }
}

private extension ViewAnimationTaskQueue {

    func processTasks() {
        if let firstTask = tasks.first {
            firstTask.animate()
        } else {
            state = .finished
        }
    }

    func cancelAllTasks() {
        queue.forEach {
            $0.cancel()
        }
        queue.removeAll()
    }

    func dequeueFirstAnimation(_ task: ViewAnimationTask) {

        if let _task = queue.first , _task === task {
            let dequeueTask = queue.removeFirst()
            dequeueTask.queue = nil
        } else {
            assertionFailure("Trying to dequeue unrecognized task \(task)")
        }
    }

    func invalidTransition(from: ViewAnimationTaskQueueState, to: ViewAnimationTaskQueueState) {
        assertionFailure("Invalid state transition \(from) -> \(to)")
    }
}
