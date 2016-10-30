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

 A `ViewAnimationTask` object is a single-shot object than can only be executed
 once.

 A `ViewAnimationTask` is executed by calling it `animate()` method or by adding
 it to a `ViewAnimationTaskQueue`. The queue will process it serially in a FIFO
 order.

 A `ViewAnimationTask` maintain state information via internally to notify the
 queue is contained by when the task finished execution.
 */
internal class ViewAnimationTask {

    fileprivate let view: UIView
    fileprivate let animation: ViewAnimation

    weak var queue: ViewAnimationTaskQueue?

    // TODO: Make this a private (set)
    // Make this a protocol and just make
    var state: ViewAnimationTaskState {
        willSet {
            switch (state, newValue) {

            case (.ready, .ready):
                break

            case (.ready, .animating):
                triggerAnimation()

            case (.ready, .finished):
                break

            case (.animating, .ready):
                invalidTransition(from: newValue, to: state)

            case (.animating, .animating):
                break

            case (.animating, .finished):
                cancelAnimation()

            case (.finished, .ready):
                invalidTransition(from: newValue, to: state)

            case (.finished, .animating):
                invalidTransition(from: newValue, to: state)

            case (.finished, .finished):
                break
            }
        }

        didSet {
            switch state {
            case .finished:
                queue?.animationDidFinish(task: self)
            case .ready, .animating:
                break
            }
        }
    }

    init(view: UIView, animation: ViewAnimation) {
        state = .ready
        self.view = view
        self.animation = animation
    }

    func animate() {
        self.state = .animating
    }

    func cancel() {
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
                                       }) { (_) in
                                            self.state = .finished
                                       }
        }
    }

    func cancelAnimation() {
        view.layer.removeAllAnimations()
    }

    func invalidTransition(from: ViewAnimationTaskState, to:ViewAnimationTaskState) {
        assertionFailure("Invalid state transition \(from) -> \(to)")
    }
}
