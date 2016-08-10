//
//  Toast.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**
 List the possible states of a Toast

 + New: Toast was created and is waiting to be shown
 + Showing: Toast is now being shown
 + DidShow: Toast did show
 + Hiding: Toast is now hiding
 + Didhide: Toast is no longer visible

 */
enum ToastState {
    case New
    case Showing
    case DidShow
    case Hiding
    case DidHide
}

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

    let content: Content
    let presentation: ToastPresentation
    let animation: ToastAnimation

    weak var queue: ToastQueue?
    private weak var presenter: ToastPresenter?

    private(set) var state: ToastState = .New {

        willSet(newState) {
            switch (state, newState) {
            case (.New, .Showing),
                 (.Showing, .DidShow),
                 (.DidShow, .Hiding),
                 (.Hiding, .DidHide):
                break
            case (.New, _),
                 (.Showing, _),
                 (.DidShow, _),
                 (.Hiding, _),
                 (.DidHide, _):
                let message = "Invalid state transition \(state) -> \(newState)"
                assertionFailure(message)
            }
        }

        didSet {
            switch state {
            case .DidHide:
                queue?.toastDidHide(self)
            case .New, .Showing, .DidShow, .Hiding:
                break
            }
        }
    }

    convenience init(text: String)  {
        let content = Content(text: text)

        self.init(content: content,
                  presentation: ToastPresentation.defaultPresentation(),
                  animation: ToastAnimation.defaultAnimations())
    }

    init(content: Content,
         presentation: ToastPresentation,
         animation: ToastAnimation) {
        self.content = content
        self.presentation = presentation
        self.animation = animation
    }

    func show(in presenter: ToastPresenter) {
        self.presenter = presenter
        presenter.show(self)
    }

    func hide() {
        presenter?.hide(self)
    }
}

extension Toast: AnimatableViewDelegate {

    func willShow() {
        state = .Showing
    }

    func didShow() {
        state = .DidShow
    }

    func willHide() {
        state = .Hiding
    }

    func didHide() {
        state = .DidHide
    }
}
