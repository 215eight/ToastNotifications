//
//  ToastQueueTests.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ToastQueueTests: XCTestCase {

    func testQueueCreation() {

        let viewController = UIViewController()
        let queue = ToastQueue(viewController: viewController)

        XCTAssertTrue(queue.status.state == .Idle)
    }

    func testQueueCanQueueToasts() {

        let viewController = UIViewController()
        let queue = ToastQueue(viewController: viewController)
        queue.queue(Toast(content: ToastContent(text: ""),
                            presentationStyle: .Plain,
                            animationStyle: .Simple))

        XCTAssertTrue(queue.status.state == .Processing, "Expected: Processing. Actual: \(queue.status.state)")
    }

    func testQueueFIFOAutomaticToastProcessing() {

        let toast1 = Toast(content: ToastContent(text: ""),
                           presentationStyle: .Plain,
                           animationStyle: .Simple)
        let toast2 = Toast(content: ToastContent(text: ""),
                           presentationStyle: .Plain,
                           animationStyle: .Simple)

        let viewController = UIViewController()
        let queue = ToastQueue(viewController: viewController)

        queue.queue(toast1)
        queue.queue(toast2)

        XCTAssertEqual(queue.status.toastCount, 2)
        XCTAssertTrue(queue.status.state == .Processing)

        XCTAssertTrue(toast1.state == .Showing)
        XCTAssertTrue(toast2.state == .New)

        toast1.didShow()

        XCTAssertEqual(queue.status.toastCount, 1)
        XCTAssertTrue(queue.status.state == .Processing)

        XCTAssertTrue(toast1.state == .DidShow)
        XCTAssertTrue(toast2.state == .Showing)

        toast2.didShow()

        XCTAssertEqual(queue.status.toastCount, 0)
        XCTAssertTrue(queue.status.state == .Idle)

        XCTAssertTrue(toast1.state == .DidShow)
        XCTAssertTrue(toast2.state == .DidShow)
    }
}
