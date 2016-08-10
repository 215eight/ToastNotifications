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

    func testToastInitializedWithNewState() {
        let toast = Toast(text: #function)
        XCTAssertTrue(toast.state == .New)
    }

    func testToastTranstionNewToShowing() {
        let toast = Toast(text: #function)
        toast.willShow()
        XCTAssertTrue(toast.state == .Showing)
    }

    func testToastTransitionShowingToShown() {
        let toast = Toast(text: #function)
        toast.willShow()
        toast.didShow()
        XCTAssertTrue(toast.state == .DidShow)
    }

    func testToastTransitionShownToHiding() {
        let toast = Toast(text: #function)
        toast.willShow()
        toast.didShow()
        toast.willHide()
        XCTAssertTrue(toast.state == .Hiding)
    }

    func testToastTransitionHidingToDidHide() {
        let toast = Toast(text: #function)
        toast.willShow()
        toast.didShow()
        toast.willHide()
        toast.didHide()
        XCTAssertTrue(toast.state == .DidHide)
    }

    func testToastCanShow() {
        let toast = Toast(text: #function)
        let presenter = StubToastPresenter()
        toast.show(in: presenter)
        XCTAssert(toast.state == .DidShow)
    }

    func testToastCanHide() {
        let toast = Toast(text: #function)
        let presenter = StubToastPresenter()
        toast.show(in: presenter)
        toast.hide()
        XCTAssert(toast.state == .DidHide)
    }

    func testToastIgnoreHideCallIfNotShowing() {
        let toast = Toast(text: #function)
        toast.hide()
        XCTAssert(toast.state == .New)
    }
}
