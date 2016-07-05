//
//  ToastAnimationStyle.swift
//  ToastNotifications
//
//  Created by pman215 on 6/6/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import UIKit

/**
 Lists the available toast animation styles

 + Simple: The view will take 1 second to fade in, stay for 2 seconds and the
 fade out in 1 second

 */
enum ToastAnimationStyle {
    case Simple
    case Custom([ViewAnimation])
}

extension ToastAnimationStyle {

    var animations: [ViewAnimation] {

        switch self {
        case .Simple:
            return simpleAnimation()

        case .Custom(let animations):
            return animations
        }
    }

    init(animation: [ViewAnimation]) {
        self = .Custom(animation)
    }
}

private extension ToastAnimationStyle {

    func simpleAnimation() -> [ViewAnimation] {

        func hide(view: UIView) {
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

        let exit = ViewAnimation()
                    .delay(2)
                    .duration(1)
                    .finalState(hide)

        return [intro, exit]
    }
}
