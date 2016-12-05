//
//  NotificationTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class NotificationTests: XCTestCase {

    func testNotificationCreation() {

        let content = Content(text: "ToastCreation")
        let appearance = Appearance()
        let animation = Animation()

        let _ = Notification(content: content,
                             appearance: appearance,
                             animation: animation)
    }

    func testNotificationCanShow() {
        let toast = Notification(text: #function)
        let presenter = StubNotificationPresenter()
        toast.show(in: presenter)
    }

    func testNotificationViewCanHide() {
        let toast = Notification(text: #function)
        let presenter = StubNotificationPresenter()
        toast.show(in: presenter)
        toast.hide()
    }
}
