//
//  ToastView.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/4/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

class ToastView: UIView {

    private var toast: Toast
    private let animationsQueue: ViewAnimationTaskQueue

    init(toast: Toast,
         animationsQueue: ViewAnimationTaskQueue = ViewAnimationTaskQueue()) {

        self.toast = toast
        self.animationsQueue = animationsQueue

        super.init(frame: toast.presentationStyle.frame)

        self.animationsQueue.delegate = self
        
        let _ = convert(bounds, toastContent:toast.content)
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

// TODO: Move to UIImage extensions

extension UIImage {

    static func nonNullImage(name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            return UIImage()
        }
        return image
    }
}