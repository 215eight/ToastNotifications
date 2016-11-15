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

    func hide()

    func removeFromHierarchy()
}

extension AnimatableView {

    func show() {
        switch state {
        case .new:
            state = .showing
            triggerShowAnimations()

        case .showing:
            assertionFailure("View is already showing")

        case .didShow:
            assertionFailure("View did show, can't show again")

        case .hiding:
            assertionFailure("View is hiding, can't show again")

        case .didHide:
            assertionFailure("View did hide, can't show again")
        }
    }

    func didShow() {
        switch state {
        case .new:
            assertionFailure("View should be in showing state")

        case .showing :
            state = .didShow
            delegate?.didShow()
            if case .autoDismiss = style { hide() }

        case .didShow:
            assertionFailure("View can only show once")
        
        case .hiding:
            assertionFailure("View must show first to start hiding")

        case .didHide:
            assertionFailure("View must show first to start hiding")
        }
    }

    func hide() {
        switch state {
        case .new:
            state = .didHide
            cancelShowAnimations()
            cancelHideAnimations()
            removeFromHierarchy()
            delegate?.didHide()

        case .showing:
            state = .didHide
            cancelShowAnimations()
            cancelHideAnimations()
            removeFromHierarchy()
            delegate?.didHide()

        case .didShow:
            state = .hiding
            triggerHideAnimations()

        case .hiding:
            state = .didHide
            cancelHideAnimations()
            removeFromHierarchy()
            delegate?.didHide()

        case .didHide:
            assertionFailure("View did hide already")
        }
    }

    func didHide() {
        switch state {
        case .new:
            assertionFailure("View can't hide without showing")

        case .showing:
            assertionFailure("View can't hide without showing")

        case .didShow:
            assertionFailure("View can't hide without showing")

        case .hiding:
            state = .didHide
            removeFromHierarchy()
            delegate?.didHide()

        case .didHide:
            assertionFailure("View did hide already")
        }
    }
}

// MARK: ViewAnimationTaskQueueDelegate Extension
extension AnimatableView {

    func queueDidFinishProcessing(_ queue: ViewAnimationTaskQueue) {
        if queue === showAnimationsQueue {
            didShow()
        } else if queue === hideAnimationsQueue {
            didHide()
        } else {
            assertionFailure("Unknown queue passed in as parameter")
        }
    }
}

private extension AnimatableView {

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

    func cancelShowAnimations() {
        showAnimationsQueue.cancel()
    }

    func cancelHideAnimations() {
        hideAnimationsQueue.cancel()
    }
}
