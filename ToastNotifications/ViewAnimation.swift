//
//  ViewAnimation.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import UIKit

/**
 A block that receives a view which properties will be updated during animation
 */
typealias AnimationState = (UIView) -> Void

/**
 Data structure that models a view animation
 */
struct ViewAnimation {

    let duration: TimeInterval
    let delay: TimeInterval
    let options: UIViewAnimationOptions
    let initialState: AnimationState
    let finalState: AnimationState

    init() {
        self.init(duration: 0,
                  delay: 0,
                  options: [.beginFromCurrentState, .curveLinear],
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

    static func duration(_ value: TimeInterval) -> ViewAnimation {
        return ViewAnimation().duration(value)
    }

    static func delay(_ value: TimeInterval) -> ViewAnimation {
        return ViewAnimation().delay(value)
    }

    static func options(_ value: UIViewAnimationOptions) -> ViewAnimation {
        return ViewAnimation().options(value)
    }

    static func initialState(_ value: @escaping AnimationState) -> ViewAnimation {
        return ViewAnimation().initialState(value)
    }

    static func finalState(_ value: @escaping AnimationState) -> ViewAnimation {
        return ViewAnimation().finalState(value)
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
