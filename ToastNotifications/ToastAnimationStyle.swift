//
//  ToastAnimationStyle.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation

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

        let intro = ViewAnimation()
                        .delay(0)
                        .duration(1)
                        .initialAnimation { (view) in
                            view.alpha = 0
                        }
                        .finalAnimation { (view) in
                            view.alpha = 1
                        }

        let exit = ViewAnimation()
                    .delay(2)
                    .duration(1)
                    .finalAnimation { (view) in
                            view.alpha = 0
                    }

        return [intro, exit]
    }
}