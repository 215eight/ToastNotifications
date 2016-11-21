//
//  Toast.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**

 A `Toast` encapsulates the following points

 + What a toast notification contains
 + Where a toast notification will be presented
 + How a toast notification will be presented

 If the context where the toast is presented only involves presentation of
 single isolated toast messages, then showing a toast by itself is safe.

 In conditions where multiple toasts messages are shown in a short period of
 time, it is recommended to use a `ToastQueue` to control the presentation
 of the toast.

 */

class Toast {

    let content: ToastContent
    let presentation: ToastPresentation
    let animation: ToastAnimation

    weak var queue: ToastQueue?
    fileprivate weak var presenter: ToastPresenter?

    convenience init(text: String)  {
        let content = ToastContent(text: text)

        self.init(content: content,
                  presentation: ToastPresentation.defaultPresentation(),
                  animation: ToastAnimation.defaultAnimations())
    }

    init(content: ToastContent,
         presentation: ToastPresentation,
         animation: ToastAnimation) {
        self.content = content
        self.presentation = presentation
        self.animation = animation
    }

    func show(in presenter: ToastPresenter) {
        self.presenter = presenter
        presenter.show(toast: self)
    }

    func didShow() {
        // Override to add more functionality
    }

    func hide() {
        presenter?.hideToasts()
    }

    func didHide() {
        queue?.dequeue(self)
    }
}
