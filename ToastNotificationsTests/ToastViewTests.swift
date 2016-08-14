//
//  ToastViewTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/7/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class FakeViewAnimationTaskQueue: ViewAnimationTaskQueue {

    override func queue(animationTask: ViewAnimationTask) {
    }

    override func process() -> Bool {
        return true
    }

    override func animationDidFinish(task: ViewAnimationTask) {
    }
}
class ToastViewTests: XCTestCase {

    let toast = Toast(text: "Test Toast")
    var toastView: ToastView!

    override func setUp() {
        super.setUp()
        toastView = ToastView(toast: toast,
                              showAnimationsQueue: FakeViewAnimationTaskQueue(),
                              hideAnimationsQueue: FakeViewAnimationTaskQueue())
    }

    override func tearDown() {
        toastView = nil
        super.tearDown()
    }

    func testToastViewInitializedWithNewState() {
        let toastView = ToastView(toast: toast)
        XCTAssertTrue(toastView.state == .New)
    }

    func testToastViewTranstionNewToShowing() {
        toastView.show()
        XCTAssertTrue(toastView.state == .Showing)
    }

    func testToastViewTransitionShowingToShown() {
        toastView.show()
        toastView.didShow()
        XCTAssertTrue(toastView.state == .DidShow)
    }

    func testToastViewTransitionShownToHiding() {
        toastView.show()
        toastView.didShow()
        toastView.hide()
        XCTAssertTrue(toastView.state == .Hiding)
    }

    func testToastViewTransitionHidingToDidHide() {
        toastView.show()
        toastView.didShow()
        toastView.hide()
        toastView.didHide()
        XCTAssertTrue(toastView.state == .DidHide)
    }
}
