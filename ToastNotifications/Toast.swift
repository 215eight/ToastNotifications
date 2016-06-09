//
//  Toast.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/7/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

enum ToastState {
    case New
    case Showing
    case DidShow
}

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
            case (.New, .New),
                 (.Showing, .Showing),
                 (.DidShow, .DidShow):
                fatalError("Invalid state transition \(state) -> \(newState)")
            default:
                fatalError("Invalid state transition \(state) -> \(newState)")
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

// Interop extensions
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

// TODO: Move these to another file and import UIKit there
func show(toast: Toast, inViewController viewController: UIViewController) {

    guard let rootView = viewController.view else {
        fatalError("No view to present toast")
    }

    let toastView = ToastView(toast: toast)
    toastView.hidden = true
    rootView.addSubview(toastView)
    rootView.bringSubviewToFront(toastView)

    toastView.show()
}
