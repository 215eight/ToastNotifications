//
//  ViewAnimationTask.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import UIKit

/**
 A `ViewAnimationTask` represents the life span of the execution of an
 `ViewAnimation`

 A `ViewAnimationTask` object is a single-shot object thus can't be reused
 */

internal class ViewAnimationTask {
    
    /**
     + Ready: Initialized and is ready to animate
     + Animating: Task started and is animating
     + Finished: View animation finished either by completion or cancellation
     */
    internal enum ViewAnimationTaskState {
        case ready
        case animating
        case finished
    }

    fileprivate let view: UIView
    fileprivate let animation: ViewAnimation
    fileprivate(set) var state: ViewAnimationTaskState

    weak var queue: ViewAnimationTaskQueue?

    init(view: UIView, animation: ViewAnimation) {
        self.view = view
        self.animation = animation
        state = .ready
    }

    func animate() {

        switch state {

        case .ready:
            state = .animating
            triggerAnimation()

        case .animating:
            assertionFailure("Task is already animating. Call is being dismissed")

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
        queue?.dequeue(task: self)
    }
}
