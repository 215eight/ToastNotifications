//
//  Notification.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation

/**

 A `Notification` encapsulates the following points

 - Content: Notification body composed by attributed text or images
 - Appearance: Notification look and feel, size and position
 - Animation: How a notification will show and hide

 */

class Notification {

    let content: Content
    let appearance: Appearance
    let animation: Animation

    weak var queue: NotificationQueue?
    fileprivate weak var presenter: NotificationPresenter?

    convenience init(text: String)  {
        let content = Content(text: text)

        self.init(content: content,
                  appearance: Appearance(),
                  animation: Animation())
    }

    init(content: Content,
         appearance: Appearance,
         animation: Animation) {
        self.content = content
        self.appearance = appearance
        self.animation = animation
    }

    func show(in presenter: NotificationPresenter) {
        self.presenter = presenter
        presenter.show(notification: self)
    }

    func didShow() {
        // Override to add more functionality
    }

    func hide() {
        presenter?.hideNotifications()
    }

    func didHide() {
        queue?.dequeue(self)
    }
}
