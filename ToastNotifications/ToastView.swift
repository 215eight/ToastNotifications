//
//  ToastView.swift
//  ToastNotifications
//
//  Created by pman215 on 6/4/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 A `ToastView` object is in charge of presenting, animating and translating a
 `Toast` object into UI elements.
 */
class ToastView: UIView {

    private weak var _delegate: AnimatableViewDelegate?

    private let toast: Toast

    private let _showAnimationsQueue: ViewAnimationTaskQueue
    private let _hideAnimationsQueue: ViewAnimationTaskQueue

    private var _showAnimations = [ViewAnimationTask]()
    private var _hideAnimations = [ViewAnimationTask]()

    init(toast: Toast,
         showAnimationsQueue: ViewAnimationTaskQueue = ViewAnimationTaskQueue(),
         hideAnimationsQueue: ViewAnimationTaskQueue = ViewAnimationTaskQueue()) {

        self.toast = toast
        _showAnimationsQueue = showAnimationsQueue
        _hideAnimationsQueue = hideAnimationsQueue

        super.init(frame: CGRect.zero)

        _showAnimationsQueue.delegate = self
        _hideAnimationsQueue.delegate = self

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(toast:showAnimationsQueue:hideAnimationsQueue:)")
    }

    func configure(with view: UIView) {
        buildContentView()
        buildViewAnimations()
        buildStyle(with: view)
    }
}

private extension ToastView {

    func buildContentView() {

        let contentView = ToastNotifications.convert(content: toast.content)
        addSubview(contentView)

        translatesAutoresizingMaskIntoConstraints = false

        let width = NSLayoutConstraint(item: contentView,
                           attribute: .Width,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Width,
                           multiplier: 1.0,
                           constant: 0)

        let height = NSLayoutConstraint(item: contentView,
                           attribute: .Height,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .Height,
                           multiplier: 1.0,
                           constant: 0.0)

        let centerX = NSLayoutConstraint(item: contentView,
                           attribute: .CenterX,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .CenterX,
                           multiplier: 1.0,
                           constant: 0.0)

        let centerY = NSLayoutConstraint(item: contentView,
                           attribute: .CenterY,
                           relatedBy: .Equal,
                           toItem: self,
                           attribute: .CenterY,
                           multiplier: 1.0,
                           constant: 0.0)

        NSLayoutConstraint.activateConstraints([width,height,centerX,centerY])
    }

    func buildViewAnimations() {
        buildShowViewAnimations()
        buildHideViewAnimations()
    }

    func buildShowViewAnimations() {
        _showAnimations = toast.animation.showAnimations.map {
            ViewAnimationTask(view: self, animation: $0)
        }
    }

    func buildHideViewAnimations() {
        _hideAnimations = toast.animation.hideAnimations.map {
            ViewAnimationTask(view: self, animation: $0)
        }
    }

    func buildStyle(with view: UIView) {
        hidden = true
        view.addSubview(self)
        view.bringSubviewToFront(self)
        toast.presentation.configure(with: self)
    }
}

extension ToastView: AnimatableView {

    var delegate: AnimatableViewDelegate? {
        get {
            return _delegate
        }
        set(newDelegate) {
            _delegate = newDelegate
        }
    }

    var showAnimationsQueue: ViewAnimationTaskQueue {
        return _showAnimationsQueue
    }

    var hideAnimationsQueue: ViewAnimationTaskQueue {
        return _hideAnimationsQueue
    }

    var showAnimations: [ViewAnimationTask] {
        return _showAnimations
    }

    var hideAnimations: [ViewAnimationTask] {
        return _hideAnimations
    }
}

extension ToastView: ViewAnimationTaskQueueDelegate {

    func queueDidFinishProcessing(queue: ViewAnimationTaskQueue) {
        if queue === showAnimationsQueue {
            didShow()
            if case .AutoDismiss = toast.animation.style {
                hide()
            }
        } else if queue === hideAnimationsQueue {
            didHide()
        } else {
            assertionFailure("Unknown queue passed in as parameter")
        }
    }
}
