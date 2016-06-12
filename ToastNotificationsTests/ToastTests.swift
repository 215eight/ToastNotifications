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

        let content = ToastContent(text: "")
        let presentationStyle = ToastPresentationStyle.Plain
        let animationStyle = ToastAnimationStyle.Simple

        let _ = Toast(content: content,
                          presentationStyle: presentationStyle,
                          animationStyle: animationStyle)
    }

    func testToastCanShow() {

        let content = ToastContent(text: "")
        let presentationStyle = ToastPresentationStyle.Plain
        let animationStyle = ToastAnimationStyle.Simple

        let toast = Toast(content: content,
                          presentationStyle: presentationStyle,
                          animationStyle: animationStyle)


        let toastView = ToastView(toast: toast)

        XCTAssertTrue(toast.state == .New)

        toastView.show()

        XCTAssertTrue(toast.state == .Showing)

        toastView.didShow()

        XCTAssertTrue(toast.state == .DidShow)
    }
}
