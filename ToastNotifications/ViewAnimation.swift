//
//  ViewAnimation.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
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
internal struct ViewAnimation {

    let duration: TimeInterval
    let delay: TimeInterval
    let options: UIViewAnimationOptions
    let initialState: AnimationState
    let finalState: AnimationState

    init() {
        self.init(duration: 0,
                  delay: 0,
                  options: .layoutSubviews,
                  initialState: { (_) in },
                  finalState: { (_) in })
    }

    init(duration: TimeInterval,
                 delay: TimeInterval,
                 options: UIViewAnimationOptions,
                 initialState: @escaping AnimationState,
                 finalState: @escaping AnimationState) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.initialState = initialState
        self.finalState = finalState
    }

    func duration(_ duration: TimeInterval) -> ViewAnimation{
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func delay(_ delay: TimeInterval) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func options(_ options: UIViewAnimationOptions) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func initialState(_ initialState: @escaping AnimationState) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }

    func finalState(_ finalState: @escaping AnimationState) -> ViewAnimation {
        return ViewAnimation(duration: duration,
                              delay: delay,
                              options: options,
                              initialState: initialState,
                              finalState: finalState)
    }
}
