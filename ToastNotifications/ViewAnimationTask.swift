//
//  ViewAnimationTask.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 Lists the possible states of a `ViewAnimationTask`

 + Ready: View animation task was initialized and is ready to animate
 + Animating: View animation task started animating. It will continue in this
 state until the animation finished
 + Finished: View animation task finished
 */
internal enum ViewAnimationTaskState {
    case ready
    case animating
    case finished
}

/**
 The `ViewAnimationTask` encapsulates the code and data associated with a view
 animation task.

 A `ViewAnimationTask` object is a single-shot object that will animate its view
 with its animation.

 The animation is triggered by calling its `animate` method. When added to a
 `ViewAnimationTaskQueue`, it will be processed serially in a FIFO order.

 If the `ViewAnimationTask` finished its animation it will call its queue
 callback to notifiy. If the animation is cut short the queue is not notified
 */

internal class ViewAnimationTask {

    fileprivate let view: UIView
    fileprivate let animation: ViewAnimation

    weak var queue: ViewAnimationTaskQueue?

    fileprivate(set) var state: ViewAnimationTaskState

    init(view: UIView, animation: ViewAnimation) {
        state = .ready
        self.view = view
        self.animation = animation
    }

    func animate() {

        switch state {

        case .ready:
            state = .animating
            triggerAnimation()

        case .animating:
            assertionFailure("Task is already animating. Call is dismissed")

        case .finished:
            assertionFailure("Task already finished animating, can't animate again.")
        }
    }

    func cancel() {
        view.layer.removeAllAnimations()
        state = .finished
    }
}

private extension ViewAnimationTask {

    func triggerAnimation() {
        DispatchQueue.main.async {
            self.view.isHidden = false
            self.animation.initialState(self.view)
            
            UIView.animate(withDuration: self.animation.duration,
                                       delay: self.animation.delay,
                                       options: self.animation.options,
                                       animations: { 
                                            self.animation.finalState(self.view)
                                       }) { (finished) in
                                            if finished {
                                                self.notifiyQueueAnimationDidFinish()
                                            }
                                       }
        }
    }

    func notifiyQueueAnimationDidFinish() {
        state = .finished
        queue?.animationDidFinish(task: self)
    }
}
