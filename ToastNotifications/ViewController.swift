//
//  ViewController.swift
//  ToastNotifications
//
//  Created by pman215 on 6/1/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var toastQueue: ToastQueue = {
        return ToastQueue(presenter: self.view)
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let content = ToastContent(text: "Waiting....")
        let presentation = ToastPresentation.defaultPresentation()
        let showAnimation = ViewAnimation(duration: 1.0,
                                          delay: 0.0,
                                          options: .allowAnimatedContent,
                                          initialState: { view in
                                             view.alpha = 0
                                          }, finalState: { view in
                                             view.alpha = 1
                                          })
        let hideAnimation = ViewAnimation(duration: 3.0,
                                          delay: 0.0,
                                          options: .allowAnimatedContent,
                                          initialState: { view in
                                             //empty
                                          }, finalState: { view in
                                             //empty
                                             view.alpha = 0
                                          })

        let animation = ToastAnimation(transition: .automatic,
                                       showAnimations: [showAnimation],
                                       hideAnimations: [hideAnimation])

        let waitToast = Toast(content: content, presentation: presentation, animation: animation)
        view.show(toast: waitToast)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.view.hideToasts()
        }

//        let content = ToastContent(text: "Waiting....")
//        let presentation = ToastPresentation.defaultPresentation()
//        let showAnimation = ViewAnimation(duration: 1.0,
//                                          delay: 0.0,
//                                          options: .allowAnimatedContent,
//                                          initialState: { view in
//                                             view.alpha = 0
//                                          }, finalState: { view in
//                                             view.alpha = 1
//                                          })
//        let hideAnimation = ViewAnimation(duration: 1.0,
//                                          delay: 0.0,
//                                          options: .allowAnimatedContent,
//                                          initialState: { view in
//                                             //empty
//                                          }, finalState: { view in
//                                             //empty
//                                             view.alpha = 0
//                                          })
//
//        let animation = ToastAnimation(transition: .automatic,
//                                       showAnimations: [showAnimation],
//                                       hideAnimations: [hideAnimation])
//
//        let waitToast = Toast(content: content, presentation: presentation, animation: animation)
//        view.show(toast: waitToast)
    }
}
