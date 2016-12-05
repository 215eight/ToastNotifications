//
//  NotificationView.swift
//  ToastNotifications
//
//  Created by pman215 on 11/14/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

class NotificationView: UIView {

    fileprivate let notification: Notification

    fileprivate lazy var animator: SequenceViewAnimator = {

        let transition = self.notification.animation.transition

        let showAnimations = self.notification.animation.showAnimations.map {
            ViewAnimationTask(view: self, animation: $0)
        }

        let hideAnimations = self.notification.animation.hideAnimations.map {
            ViewAnimationTask(view: self, animation: $0)
        }

        var animator = SequenceViewAnimator(transition: transition,
                                            showAnimations: showAnimations,
                                            hideAnimations: hideAnimations)
        animator.delegate = self

        return animator
    }()
    
    init(notification: Notification) {
        self.notification = notification
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with superview: UIView) {
        buildContentView()
        buildStyle(with: superview)
    }

    func show() {
        animator.show()
    }

    func hide() {
        animator.hide()
    }
}

private extension NotificationView {

    func buildContentView() {

        let contentView = ToastNotifications.convert(content: notification.content)
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

    func buildStyle(with view: UIView) {
        isHidden = true
        view.addSubview(self)
        view.bringSubview(toFront: self)
        notification.appearance.configure(with: self)
    }
}

extension NotificationView: SequenceViewAnimatorDelegate {
    
    func willShow() {

    }

    func didShow() {

    }

    func willHide() {

    }

    func didHide() {
        removeFromSuperview()
        notification.didHide()
    }
}
