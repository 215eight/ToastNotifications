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

        animationsQueue.delegate = self
        
        let _ = toast.animationStyle.animations.map {
            return ViewAnimationTask(view: self, animation: $0)
        }.map{
            animationsQueue.queue($0)
        }

        let uiElements = convert(toast.content, container: self)
        let _ = uiElements.0.map {
            addSubview($0)
        }

        let _ = uiElements.1.map {
            $0.active = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(toast: style:")
    }

    func show() {
        toast.presentationStyle.styleConfiguration()(self)
        toast.isShowing()
        animationsQueue.process()
    }

    func didShow() {
        removeFromSuperview()
        toast.didShow()
    }
}

extension ToastView: ViewAnimationTaskQueueDelegate {

    func queueDidFinishProcessing(queue: ViewAnimationTaskQueue) {
        didShow()
    }
}
