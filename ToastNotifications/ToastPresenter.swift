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
    func hideToasts()
}

extension ToastPresenter where Self: UIView {

    func show(view: ToastView) {
        view.show()
    }

    func hide(view: ToastView) {
        view.hide()
    }
}

extension UIView: ToastPresenter {

    func show(toast: Toast) {
        let toastView = ToastView(toast: toast)
        toastView.configure(with: self)
        show(view: toastView)
    }

    func hideToasts() {
        subviews.flatMap { $0 as? ToastView }
                .forEach { hide(view: $0) }
    }
}
