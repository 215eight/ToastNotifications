//
//  AnimatableView.swift
//  ToastNotifications
//
//  Created by pman215 on 7/23/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

enum AnimatableViewState {
    case New
    case Showing
    case DidShow
    case Hiding
    case DidHide
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
        state = .Showing
        delegate?.willShow()
        queueShowAnimations()
        showAnimationsQueue.process()
    }

    mutating func didShow() {
        state = .DidShow
        delegate?.didShow()
    }

    mutating func hide() {
        state = .Hiding
        delegate?.willHide()
        queueHideAnimations()
        hideAnimationsQueue.process()
    }

    mutating func didHide() {
        state = .DidHide
        delegate?.didHide()
    }
}

private extension AnimatableView {

    func queueShowAnimations() {
        showAnimations.forEach {
            showAnimationsQueue.queue($0)
        }
    }

    func queueHideAnimations() {
        hideAnimations.forEach {
            hideAnimationsQueue.queue($0)
        }
    }

}
