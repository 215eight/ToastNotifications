//
//  AnimatableView.swift
//  ToastNotifications
//
//  Created by pman215 on 7/23/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

enum AnimatableViewState {
    case new
    case showing
    case didShow
    case hiding
    case didHide
}

protocol AnimatableViewDelegate: class {

    func willShow()
    func didShow()
    func willHide()
    func didHide()
}

protocol AnimatableView: ViewAnimationTaskQueueDelegate  {

    var state: AnimatableViewState { get set }
    var style: ViewAnimationStyle { get }
    weak var delegate: AnimatableViewDelegate? { get set }
    var showAnimations: [ViewAnimationTask] { get }
    var hideAnimations: [ViewAnimationTask] { get }
    var showAnimationsQueue: ViewAnimationTaskQueue { get }
    var hideAnimationsQueue: ViewAnimationTaskQueue { get }

    func show()

    func didShow()

    func hide()

    func didHide()

    func removeFromHierarchy()
}

extension AnimatableView {

    func show() {
        set(state: .showing)
    }

    func didShow() {
        set(state: .didShow)
        delegate?.didShow()
    }

    func hide() {
        set(state: .hiding)
    }

    func didHide() {
        set(state: .didHide)
        delegate?.didHide()
    }
}

// MARK: ViewAnimationTaskQueueDelegate Extension
extension AnimatableView {

    func queueDidFinishProcessing(_ queue: ViewAnimationTaskQueue) {
        if queue === showAnimationsQueue {
            didShow()
            if case .autoDismiss = style {
                hide()
            }
        } else if queue === hideAnimationsQueue {
            didHide()
            removeFromHierarchy()
        } else {
            assertionFailure("Unknown queue passed in as parameter")
        }
    }
}

private extension AnimatableView {

    func set(state: AnimatableViewState) {
        let oldState = self.state
        self.state = state
        validateTransition(from: oldState, to: state)
    }

    func validateTransition(from oldState: AnimatableViewState, to newState: AnimatableViewState) {
        switch (oldState, newState) {

        case (.new, .new):
            invalidTransition(from: oldState, to: newState)

        case (.new, .showing):
            triggerShowAnimations()

        case (.new, .didShow):
            invalidTransition(from: oldState, to: newState)

        case (.new, .hiding):
            cancelShowAnimations()
            cancelHideAnimations()
            state = .didHide

        case (.new, .didHide):
            invalidTransition(from: oldState, to: newState)

        case (.showing, .new):
            invalidTransition(from: oldState, to: newState)

        case (.showing, .showing):
            invalidTransition(from: oldState, to: newState)

        case (.showing, .didShow):
            break

        case (.showing, .hiding):
            cancelHideAnimations()
            state = .didHide

        case (.showing, .didHide):
            invalidTransition(from: oldState, to: newState)

        case (.didShow, .new):
            invalidTransition(from: oldState, to: newState)

        case (.didShow, .showing):
            invalidTransition(from: oldState, to: newState)

        case (.didShow, .didShow):
            invalidTransition(from: oldState, to: newState)

        case (.didShow, .hiding):
            triggerHideAnimations()

        case (.didShow, .didHide):
            invalidTransition(from: oldState, to: newState)

        case (.hiding, .new):
            invalidTransition(from: oldState, to: newState)

        case (.hiding, .showing):
            invalidTransition(from: oldState, to: newState)

        case (.hiding, .didShow):
            invalidTransition(from: oldState, to: newState)

        case (.hiding, .hiding):
            invalidTransition(from: oldState, to: newState)

        case (.hiding, .didHide):
            break

        case (.didHide, .new):
            invalidTransition(from: oldState, to: newState)

        case (.didHide, .showing):
            invalidTransition(from: oldState, to: newState)

        case (.didHide, .didShow):
            invalidTransition(from: oldState, to: newState)

        case (.didHide, .hiding):
            invalidTransition(from: oldState, to: newState)

        case (.didHide, .didHide):
            invalidTransition(from: oldState, to: newState)
        }
    }

    func invalidTransition(from: AnimatableViewState, to: AnimatableViewState) {
        assertionFailure("Invalid state transition: \(from) -> \(to)")
    }

    func triggerShowAnimations() {
        delegate?.willShow()
        queueShowAnimations()
        showAnimationsQueue.process()
    }

    func queueShowAnimations() {
        showAnimations.forEach {
            showAnimationsQueue.queue(task: $0)
        }
    }

    func cancelShowAnimations() {
        showAnimationsQueue.cancel()
    }


    func triggerHideAnimations() {
        delegate?.willHide()
        queueHideAnimations()
        hideAnimationsQueue.process()
    }

    func queueHideAnimations() {
        hideAnimations.forEach {
            hideAnimationsQueue.queue(task: $0)
        }
    }

    func cancelHideAnimations() {
        hideAnimationsQueue.cancel()
    }
}
