//
//  AnimatableView.swift
//  ToastNotifications
//
//  Created by pman215 on 7/23/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

protocol AnimatableViewDelegate: class {

    func willShow()
    func didShow()
    func willHide()
    func didHide()
}

protocol AnimatableView {

    weak var delegate: AnimatableViewDelegate? { get set }
    var showAnimations: [ViewAnimationTask] { get }
    var hideAnimations: [ViewAnimationTask] { get }
    var showAnimationsQueue: ViewAnimationTaskQueue { get }
    var hideAnimationsQueue: ViewAnimationTaskQueue { get }

    func show()

    func didShow()

    func hide()

    func didHide()
}

extension AnimatableView {

    func show() {
        delegate?.willShow()
        queueShowAnimations()
        showAnimationsQueue.process()
    }

    func didShow() {
        delegate?.didShow()
    }

    func hide() {
        delegate?.willHide()
        queueHideAnimations()
        hideAnimationsQueue.process()
    }

    func didHide() {
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
