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
    var state: ViewAnimationTaskState = .ready {
        willSet {
            switch (state, newValue) {

            case (.ready, .animating),
                 (.animating, .finished):
                break
            case (.ready, _),
                 (.animating, _),
                 (.finished, _):
                assertionFailure("Invalid state transition \(state) -> \(newValue)")
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
        self.view = view
        self.animation = animation
    }

    func animate() {

        DispatchQueue.main.async {
            self.state = .animating

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

}
