//
//  Toast.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 List the possible states of a Toast

 + New: Toast was created and is waiting to be shown

 + Showing: Toast is now being shown

 + DidShow: Toast did show

 */
enum ToastState {
    case New
    case Showing
    case DidShow
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

@objc class Toast: NSObject {

    let content: ToastContent
    let presentationStyle: ToastPresentationStyle
    let animationStyle: ToastAnimationStyle

    weak var queue: ToastQueue?

    private (set) var state: ToastState = .New {

        willSet(newState) {
            switch (state, newState) {
            case (.New, .Showing),
                 (.Showing, .DidShow):
                break
            case (.New, _),
                 (.Showing, _),
                 (.DidShow, _):
                let message = "Invalid state transition \(state) -> \(newState)"
                assertionFailure(message)
            }
        }

        didSet {
            switch state {
            case .DidShow:
                queue?.toastDidShow(self)
            case .New, .Showing:
                break
            }
        }
    }

    init(content: ToastContent,
         presentationStyle: ToastPresentationStyle,
         animationStyle: ToastAnimationStyle) {
        self.content = content
        self.presentationStyle = presentationStyle
        self.animationStyle = animationStyle
    }

    func isShowing() {
        state = .Showing
    }

    func didShow() {
        state = .DidShow
    }
}

// MARK: Obj-C Interoerability
extension Toast {

    convenience init(text: String) {

        let content = ToastContent.Element(ToastSize(width: 16, height: 1), .Text(text))
        let presentationStyle = ToastPresentationStyle.Plain
        let animatiionStyle = ToastAnimationStyle.Simple

        self.init(content: content,
                  presentationStyle: presentationStyle,
                  animationStyle: animatiionStyle)
    }
}

// MARK: Model to View Conversion
func show(toast: Toast, inViewController viewController: UIViewController) {

    guard viewController.isViewLoaded(), let rootView = viewController.view else {
        let message = "No view available to show toast"
        assertionFailure(message)
        return
    }

    let toastView = ToastView(toast: toast)
    toastView.hidden = true
    rootView.addSubview(toastView)
    rootView.bringSubviewToFront(toastView)

    toastView.show()
}
