//
//  ToastTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastTests: XCTestCase {

    func testToastCreation() {

        let content = Content(text: "ToastCreation")
        let presentation = ToastPresentation.defaultPresentation()
        let animation = ToastAnimation.defaultAnimations()

        let _ = Toast(content: content,
                          presentation: presentation,
                          animation: animation)
    }

    func testToastCanShow() {
        let toast = Toast(text: #function)
        let presenter = StubToastPresenter()
        toast.show(in: presenter)
    }

    func testToastViewCanHide() {
        let toast = Toast(text: #function)
        let presenter = StubToastPresenter()
        toast.show(in: presenter)
        toast.hide()
    }
}
