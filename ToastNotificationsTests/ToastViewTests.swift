//
//  ToastViewTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastViewTests: XCTestCase {

    func testToatViewCreation() {

        let toastText = ToastContent(text: "Testy Toasty")
        let toastImage = ToastContent(imageName: "image")
        let toastContent = toastText ||| toastImage

        let toast = Toast(content: toastContent,
                          presentationStyle: .Plain,
                          animationStyle: .Simple)

        let toastView = ToastView(toast: toast)

        XCTAssertEqual(toastView.subviews.count, 2)
    }
}
