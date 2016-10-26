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

protocol AnimatableView {

    var state: AnimatableViewState { get set }
    weak var delegate: AnimatableViewDelegate? { get set }
    var showAnimations: [ViewAnimationTask] { get }
    var hideAnimations: [ViewAnimationTask] { get }
    var showAnimationsQueue: ViewAnimationTaskQueue { get }
    var hideAnimationsQueue: ViewAnimationTaskQueue { get }

    mutating func show()

    mutating func didShow()

    mutating func hide()

    mutating func didHide()
}

extension AnimatableView {

    mutating func show() {
        state = .showing
        delegate?.willShow()
        queueShowAnimations()
        _ = showAnimationsQueue.process()
    }

    mutating func didShow() {
        state = .didShow
        delegate?.didShow()
    }

    mutating func hide() {
        state = .hiding
        delegate?.willHide()
        queueHideAnimations()
        _ = hideAnimationsQueue.process()
    }

    mutating func didHide() {
        state = .didHide
        delegate?.didHide()
    }
}

private extension AnimatableView {

    func queueShowAnimations() {
        showAnimations.forEach {
            showAnimationsQueue.queue(task: $0)
        }
    }

    func queueHideAnimations() {
        hideAnimations.forEach {
            hideAnimationsQueue.queue(task: $0)
        }
    }

}
