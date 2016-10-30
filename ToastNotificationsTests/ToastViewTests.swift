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

    override func queue(task: ViewAnimationTask) {
    }

    override func process() {

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
        XCTAssertTrue(toastView.state == .new)
    }

    func testToastViewTranstionNewToShowing() {
        toastView.show()
        XCTAssertTrue(toastView.state == .showing)
    }

    func testToastViewTransitionShowingToShown() {
        toastView.show()
        toastView.didShow()
        XCTAssertTrue(toastView.state == .didShow)
    }

    func testToastViewTransitionShownToHiding() {
        toastView.show()
        toastView.didShow()
        toastView.hide()
        XCTAssertTrue(toastView.state == .hiding)
    }

    func testToastViewTransitionHidingToDidHide() {
        toastView.show()
        toastView.didShow()
        toastView.hide()
        toastView.didHide()
        XCTAssertTrue(toastView.state == .didHide)
    }
}
