//
//  Animation.swift
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

struct Animation {
    let transition: ViewAnimationTransition
    let showAnimations: [ViewAnimation]
    let hideAnimations: [ViewAnimation]

    init() {
        let transition: ViewAnimationTransition = .automatic
        let showAnimations = Animation.defaultShowAnimations()
        let hideAnimations = Animation.defaultHideAnimations()

        self.init(transition: transition,
                  showAnimations: showAnimations,
                  hideAnimations: hideAnimations)
    }

    init(transition: ViewAnimationTransition,
         showAnimations: [ViewAnimation],
         hideAnimations: [ViewAnimation]) {
        self.transition = transition
        self.showAnimations = showAnimations
        self.hideAnimations = hideAnimations
    }
}

extension Animation {

    static func defaultShowAnimations() -> [ViewAnimation] {
        func hide(_ view: UIView) {
            view.alpha = 0
        }
        
        func show(view: UIView) {
            view.alpha = 1
        }
        
        let showAnimation = ViewAnimation()
            .duration(1)
            .initialState(hide)
            .finalState(show)

        return [showAnimation]
    }

    static func defaultHideAnimations() -> [ViewAnimation] {
        func hide(view: UIView) {
            view.alpha = 0
        }
        
        let hideAnimation = ViewAnimation()
            .delay(1)
            .duration(1)
            .finalState(hide)
        
        return [hideAnimation]
    }
}
