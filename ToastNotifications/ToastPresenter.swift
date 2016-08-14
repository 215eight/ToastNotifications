//
//  ToastPresenter.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

protocol ToastPresenter: class {

    func show(toast: Toast)
    func hide(toast: Toast)
}

extension UIView: AnimatableViewPresenter {

    func show(view: AnimatableView) {
        var view = view
        view.show()
    }

    func hide(view: AnimatableView) {
        var view = view
        view.hide()
    }

}

extension UIView: ToastPresenter {

    func show(toast: Toast) {
        let toastView = ToastView(toast: toast)
        toastView.configure(with: self)
        toastView.delegate = toast
        show(toastView)
    }

    // TODO: Remove the toast param
    func hide(toast: Toast) {
        for subview in subviews {
            if let animatableView = subview as? AnimatableView {
                hide(animatableView)
            }
        }
    }
}
