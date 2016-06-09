//
//  ViewAnimation.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

typealias Animation = (UIView) -> Void

struct ViewAnimation {

    private (set) var duration: NSTimeInterval = 0
    private (set) var delay: NSTimeInterval = 0
    private (set) var options: UIViewAnimationOptions = .LayoutSubviews
    private (set) var initialAnimation: Animation = { (_) in }
    private (set) var finalAnimation: Animation = { (_) in }

    init() { }

    private init(duration: NSTimeInterval,
                 delay: NSTimeInterval,
                 options: UIViewAnimationOptions,
                 initialAnimation: Animation,
                 finalAnimation: Animation) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.initialAnimation = initialAnimation
        self.finalAnimation = finalAnimation
    }

    func duration(duration: NSTimeInterval) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialAnimation: initialAnimation,
                              finalAnimation: finalAnimation)
    }

    func delay(delay: NSTimeInterval) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialAnimation: initialAnimation,
                              finalAnimation: finalAnimation)
    }

    func options(options: UIViewAnimationOptions) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialAnimation: initialAnimation,
                              finalAnimation: finalAnimation)
    }

    func initialAnimation(initialAnimation: Animation) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialAnimation: initialAnimation,
                              finalAnimation: finalAnimation)
    }

    func finalAnimation(finalAnimation: Animation) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialAnimation: initialAnimation,
                              finalAnimation: finalAnimation)
    }
}