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
class ToastView: UIView, AnimatableView {

    // MARK: AnimatableView Properties Begin
    var state: AnimatableViewState

    weak var delegate: AnimatableViewDelegate?

    let showAnimationsQueue: ViewAnimationTaskQueue
    let hideAnimationsQueue: ViewAnimationTaskQueue

    var showAnimations = [ViewAnimationTask]()
    var hideAnimations = [ViewAnimationTask]()

    var style: ViewAnimationStyle {
        return toast.animation.style
    }

    func removeFromHierarchy() {
        removeFromSuperview()
    }
    // MARK: AnimatbleView Properties End

    fileprivate let toast: Toast

    init(toast: Toast,
         showAnimationsQueue: ViewAnimationTaskQueue = ViewAnimationTaskQueue(),
         hideAnimationsQueue: ViewAnimationTaskQueue = ViewAnimationTaskQueue()) {

        self.toast = toast
        self.showAnimationsQueue = showAnimationsQueue
        self.hideAnimationsQueue = hideAnimationsQueue

        state = .new

        super.init(frame: CGRect.zero)

        showAnimationsQueue.delegate = self
        hideAnimationsQueue.delegate = self

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
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self,
                                       attribute: .width,
                                       multiplier: 1.0,
                                       constant: 0)

        let height = NSLayoutConstraint(item: contentView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: .height,
                                        multiplier: 1.0,
                                        constant: 0.0)

        let centerX = NSLayoutConstraint(item: contentView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0.0)

        let centerY = NSLayoutConstraint(item: contentView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0.0)

        NSLayoutConstraint.activate([width,height,centerX,centerY])
    }

    func buildViewAnimations() {
        buildShowViewAnimations()
        buildHideViewAnimations()
    }

    func buildShowViewAnimations() {
        showAnimations = toast.animation.showAnimations.map {
            ViewAnimationTask(view: self, animation: $0)
        }
    }

    func buildHideViewAnimations() {
        hideAnimations = toast.animation.hideAnimations.map {
            ViewAnimationTask(view: self, animation: $0)
        }
    }

    func buildStyle(with view: UIView) {
        isHidden = true
        view.addSubview(self)
        view.bringSubview(toFront: self)
        toast.presentation.configure(with: self)
    }
}
