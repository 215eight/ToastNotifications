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

    private var toast: Toast
    private let animationsQueue: ViewAnimationTaskQueue

    init(toast: Toast,
         animationsQueue: ViewAnimationTaskQueue = ViewAnimationTaskQueue()) {

        self.toast = toast
        self.animationsQueue = animationsQueue

        super.init(frame: CGRect.zero)

        self.animationsQueue.delegate = self
        
        let _ = toast.animationStyle.animations.map {
            return ViewAnimationTask(view: self, animation: $0)
        }.map{
            animationsQueue.queue($0)
        }

        toast.presentationStyle.styleConfiguration()(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(toast: style:")
    }

    func show() {

        addSubviews()
        configureConstraints()
        toast.isShowing()
        animationsQueue.process()
    }

    func didShow() {
        removeFromSuperview()
        toast.didShow()
    }
}

private extension ToastView {

    func addSubviews() {
        // For this line to work the superview needs to have defined bounds
        if let superview = superview {

            let _size = CGSize(width: superview.bounds.width * 0.9,
                               height: superview.bounds.height * 0.1)

            let _frame = CGRect(origin: CGPoint.zero,
                                size: _size)

            let _ = convert(toast.content, frame: _frame)
                        .map { addSubview($0) }
        } else {
            let message = "Superview is nil. Add view to the view hierarchy"
            assertionFailure(message)
        }
    }

    func configureConstraints() {

        translatesAutoresizingMaskIntoConstraints = false

        if let superview = superview {

            let widthRatio = toast.presentationStyle.widthRatio(superview)
            let width = NSLayoutConstraint(item: self,
                                           attribute: .Width,
                                           relatedBy: .GreaterThanOrEqual,
                                           toItem: superview,
                                           attribute: .Width,
                                           multiplier: widthRatio,
                                           constant: 0)

            let heightRatio = toast.presentationStyle.heightRatio(superview)
            let height = NSLayoutConstraint(item: self,
                                            attribute: .Height,
                                            relatedBy: .GreaterThanOrEqual,
                                            toItem: superview,
                                            attribute: .Height,
                                            multiplier: heightRatio,
                                            constant: 0)

            let centerXRatio = toast.presentationStyle.cneterXRatio(superview)
            let centerX = NSLayoutConstraint(item: self,
                                             attribute: .CenterX,
                                             relatedBy: .Equal,
                                             toItem: superview,
                                             attribute: .CenterX,
                                             multiplier: centerXRatio,
                                             constant: 0)

            let centerYRatio = toast.presentationStyle.centerYRatio(superview)
            let centerY = NSLayoutConstraint(item: self,
                                             attribute: .CenterY,
                                             relatedBy: .Equal,
                                             toItem: superview,
                                             attribute: .CenterY,
                                             multiplier: centerYRatio,
                                             constant: 0)

            superview.addConstraints([width, height, centerX, centerY])

        } else {
            let message = "Superview is nil. Add view to the view hierarchy"
            assertionFailure(message)
        }
    }
}

extension ToastView: ViewAnimationTaskQueueDelegate {

    func queueDidFinishProcessing(queue: ViewAnimationTaskQueue) {
        didShow()
    }
}
