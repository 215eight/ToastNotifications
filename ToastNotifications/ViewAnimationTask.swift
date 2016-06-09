//
//  ViewAnimationTask.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/6/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import Foundation
import UIKit

enum ViewAnimationTaskState {
    case Ready
    case Animating
    case Finished
}

class ViewAnimationTask {

    private let view: UIView
    private let animation: ViewAnimation

    weak var queue: ViewAnimationTaskQueue?

    // TODO: Make this a private (set)
    // Make this a protocol and just make
    var state: ViewAnimationTaskState = .Ready {
        willSet {
            switch (state, newValue) {

            case (.Ready, .Animating):
                break
            case (.Animating, .Finished):
                break
            case (.Ready, .Ready), (.Animating, .Animating), (.Finished, .Finished):
                fatalError("Invalid state transition \(state) -> \(newValue)")
            default:
                fatalError("Invalid state transition \(state) -> \(newValue)")
            }
        }

        didSet {
            switch state {
            case .Finished:
                queue?.animationDidFinish(self)
            default:
                break
            }
        }
    }

    init(view: UIView, animation: ViewAnimation) {
        self.view = view
        self.animation = animation
    }

    func animate() {

        dispatch_async(dispatch_get_main_queue()) {
            self.state = .Animating

            self.view.hidden = false
            self.animation.initialAnimation(self.view)
            
            UIView.animateWithDuration(self.animation.duration,
                                       delay: self.animation.delay,
                                       options: self.animation.options,
                                       animations: { 
                                            self.animation.finalAnimation(self.view)
                                       }) { (completion) in
                                            self.state = .Finished
                                       }
        }
    }

}