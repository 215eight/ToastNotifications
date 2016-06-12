//
//  ViewAnimation.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit


/**
 A block that receives a view and contains whatever state changes to animate
 */
typealias AnimationState = (UIView) -> Void

/**
 Data structure that models a view animation
 */
struct ViewAnimation {

    let duration: NSTimeInterval
    let delay: NSTimeInterval
    let options: UIViewAnimationOptions
    let initialState: AnimationState
    let finalState: AnimationState

    init() {
        self.init(duration: 0,
                  delay: 0,
                  options: .LayoutSubviews,
                  initialState: { (_) in },
                  finalState: { (_) in })
    }

    private init(duration: NSTimeInterval,
                 delay: NSTimeInterval,
                 options: UIViewAnimationOptions,
                 initialState: AnimationState,
                 finalState: AnimationState) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.initialState = initialState
        self.finalState = finalState
    }

    func duration(duration: NSTimeInterval) -> ViewAnimation{
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func delay(delay: NSTimeInterval) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func options(options: UIViewAnimationOptions) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func initialState(initialState: AnimationState) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func finalState(finalState: AnimationState) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }
}
