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

        super.init(frame: toast.presentationStyle.frame)

        self.animationsQueue.delegate = self
        
        let _ = convert(toast.content, frame:bounds)
                .map { addSubview($0) }

        let _ = toast.animationStyle.animations.map{
            return ViewAnimationTask(view: self, animation: $0)
        }.map{
            animationsQueue.queue($0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(toast: style:")
    }

    func show() {
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

