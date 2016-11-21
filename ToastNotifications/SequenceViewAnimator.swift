//
//  SequenceAnimator.swift
//  ToastNotifications
//
//  Created by pman215 on 11/14/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

internal protocol SequenceViewAnimatorDelegate: class {
    func willShow()
    func didShow()
    func willHide()
    func didHide()
}

internal class SequenceViewAnimator {

    fileprivate enum State {
        case new
        case showing
        case didShow
        case hiding
        case didHide
    }
    
    fileprivate var state: State
    fileprivate var transition: ViewAnimationTransition
    fileprivate let showAnimations: [ViewAnimationTask]
    fileprivate let hideAnimations: [ViewAnimationTask]
    fileprivate var animationTaskQueue = ViewAnimationTaskQueue()

    weak var delegate: SequenceViewAnimatorDelegate?

    init(transition: ViewAnimationTransition,
         showAnimations: [ViewAnimationTask],
         hideAnimations: [ViewAnimationTask]) {

        state = .new
        self.transition = transition
        self.showAnimations = showAnimations
        self.hideAnimations = hideAnimations
    }

    func show() {

        switch state {

        case .new:
            state = .showing
            triggerShowAnimations()

        case .showing:
            assertionFailure("Showing animations already started")

        case .didShow, .hiding, .didHide:
            assertionFailure("Animator can't run show animations again")
        }
    }

    fileprivate func didShow() {

        switch state {

        case .new:
            assertionFailure("Show animations have not run yet")

        case .showing :
            state = .didShow
            delegate?.didShow()
            if transition == .automatic { hide() }

        case .didShow:
            assertionFailure("Show animations can only run once")
        
        case .hiding, .didHide:
            assertionFailure("Show animations must run before hidding")
        }
    }

    func hide() {

        switch state {

        case .new:
            state = .didHide
            cancelShowAnimations()
            delegate?.didHide()

        case .showing:
            state = .didHide
            cancelShowAnimations()
            delegate?.didHide()

        case .didShow:
            state = .hiding
            triggerHideAnimations()

        case .hiding:
            state = .didHide
            cancelHideAnimations()
            delegate?.didHide()

        case .didHide:
            assertionFailure("Hide animations ran already")
        }
    }

    fileprivate func didHide() {

        switch state {

        case .new, .showing, .didShow:
            assertionFailure("Showing and hidding animations must run before")

        case .hiding:
            state = .didHide
            delegate?.didHide()

        case .didHide:
            assertionFailure("Hide animations already ran")
        }
    }
}

private extension SequenceViewAnimator {

    func initTaskQueue() {
        animationTaskQueue = ViewAnimationTaskQueue()
        animationTaskQueue.delegate = self
    }

    func triggerShowAnimations() {
        delegate?.willShow()
        initTaskQueue()
        showAnimations.forEach{ animationTaskQueue.queue(task: $0) }
        animationTaskQueue.process()
    }

    func triggerHideAnimations() {
        delegate?.willHide()
        initTaskQueue()
        hideAnimations.forEach{ animationTaskQueue.queue(task: $0) }
        animationTaskQueue.process()
    }

    func cancelShowAnimations() {
        animationTaskQueue.cancel()
    }

    func cancelHideAnimations() {
        animationTaskQueue.cancel()
    }
}

extension SequenceViewAnimator: ViewAnimationTaskQueueDelegate {

    func queueDidFinishProcessing(_ queue: ViewAnimationTaskQueue) {
        switch state {
        case .showing:
            didShow()
        case .hiding:
            didHide()
        case .new, .didShow, .didHide:
            assertionFailure("Invalid transition")
        }
    }
}
