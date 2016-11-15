//
//  AnimatableViewTests.swift
//  ToastNotifications
//
//  Created by Party Man on 10/30/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class FakeAnimatableView: AnimatableView {

    var state: AnimatableViewState = .new
    var style: ViewAnimationStyle = .manualDismiss
    weak var delegate: AnimatableViewDelegate? = nil
    var showAnimations = [ViewAnimationTask]()
    var hideAnimations = [ViewAnimationTask]()
    var showAnimationsQueue = ViewAnimationTaskQueue()
    var hideAnimationsQueue = ViewAnimationTaskQueue()

    func removeFromHierarchy() {
        // empty
    }
}

class AnimatableViewTests: XCTestCase {

    var animatableView: FakeAnimatableView!

    override func setUp() {
        super.setUp()
        animatableView = FakeAnimatableView()
        animatableView.showAnimationsQueue.delegate = animatableView
        animatableView.hideAnimationsQueue.delegate = animatableView
    }

    override func tearDown() {
        animatableView.showAnimationsQueue.delegate = nil
        animatableView.hideAnimationsQueue.delegate = nil
        animatableView = nil
        super.tearDown()
    }

    func testAnimatableViewInitialState() {
        XCTAssertEqual(animatableView.state, .new)
    }

    func testAnimatableViewCanShow() {
        animatableView.show()
        XCTAssertEqual(animatableView.state, .didShow)
    }

    func testAnimatableViewCanAutoDismiss() {
        animatableView.style = .autoDismiss
        animatableView.show()
        XCTAssertEqual(animatableView.state, .didHide)
    }

    func testAnimatableViewCanHideBeforeShowing() {
        animatableView.hide()
        XCTAssertEqual(animatableView.state, .didHide)
        XCTAssertEqual(animatableView.showAnimationsQueue.state, .finished)
        XCTAssertEqual(animatableView.hideAnimationsQueue.state, .finished)
    }

    func testAnimatableViewCanHideWhileShowing() {
        animatableView.show()
        animatableView.hide()
        XCTAssertEqual(animatableView.state, .didHide)
    }
}
