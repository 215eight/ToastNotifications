//
//  NotificationPresenter.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationPresenter: class {

    func show(notification: Notification)
    func hideNotifications()
}

extension NotificationPresenter where Self: UIView {

    func show(view: NotificationView) {
        view.show()
    }

    func hide(view: NotificationView) {
        view.hide()
    }
}

extension UIView: NotificationPresenter {

    func show(notification: Notification) {
        let notificationView = NotificationView(notification: notification)
        notificationView.configure(with: self)
        show(view: notificationView)
    }

    func hideNotifications() {
        subviews.flatMap { $0 as? NotificationView }
                .forEach { hide(view: $0) }
    }
}
