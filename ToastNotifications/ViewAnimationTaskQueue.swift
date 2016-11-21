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
 FIFO order

 A queue is a single-shot object, once it has finished processing all its tasks,
 the queue should be disposed.
 */
internal class ViewAnimationTaskQueue {

    fileprivate var queue = [ViewAnimationTask]()

    fileprivate(set) var state: ViewAnimationTaskQueueState

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

    func dequeue(task: ViewAnimationTask) {

        switch state {

        case .processing:
            remove(task)
            processTask()
        case .new:
            assertionFailure("ViewAnimationTaskQueue should be processing")

        case .finished:
            assertionFailure("ViewAnimationTaskQueue can't process tasks after finishing")
        }
    }

    func process() {

        switch state {

        case .new:
            state = .processing
            processTask()

        case .processing:
            assertionFailure("ViewAnimationTaskQueue is already processing")

        case .finished:
            assertionFailure("ViewAnimationTaskQueue is done processing.")
        }
    }

    func cancel() {

        switch state {

        case .new, .processing:
            cancelAllTasks()
            state = .finished

        case .finished:
            assertionFailure("ViewAnimationTaskQueue is done processing.")
        }
    }
}

private extension ViewAnimationTaskQueue {

    func processTask() {
        if let firstTask = queue.first {
            firstTask.animate()
        } else {
            state = .finished
            delegate?.queueDidFinishProcessing(self)
        }

    }

    func cancelAllTasks() {
        queue.forEach {
            $0.cancel()
            $0.queue = nil
        }
        queue.removeAll()
    }

    func remove(_ task: ViewAnimationTask) {
        if let _task = queue.first , _task === task {
            let dequeueTask = queue.removeFirst()
            dequeueTask.queue = nil
        } else {
            assertionFailure("Trying to dequeue unrecognized task \(task)")
        }
    }
}
