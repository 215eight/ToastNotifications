//
//  ToastAnimation.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import UIKit


enum ViewAnimationTransition {
    case automatic
    case manual
}

struct ToastAnimation {
    let transition: ViewAnimationTransition
    let showAnimations: [ViewAnimation]
    let hideAnimations: [ViewAnimation]
}

extension ToastAnimation {

    static func defaultAnimations() -> ToastAnimation {
        let transition: ViewAnimationTransition = .automatic
        let showAnimations: [ViewAnimation] = {

            func hide(_ view: UIView) {
                view.alpha = 0
            }

            func show(view: UIView) {
                view.alpha = 1
            }

            let intro = ViewAnimation()
                            .delay(0)
                            .duration(1)
                            .initialState(hide)
                            .finalState(show)

            return [intro]
        }()

        let hideAnimations: [ViewAnimation] = {

            func hide(view: UIView) {
                view.alpha = 0
            }

            let exit = ViewAnimation()
                            .delay(1)
                            .duration(1)
                            .finalState(hide)

            return [exit]
        }()

        return ToastAnimation(transition: transition,
                              showAnimations: showAnimations,
                              hideAnimations: hideAnimations)
    }
}
