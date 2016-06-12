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
        return ToastQueue(viewController: self)
    }()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let toast1 = ToastContent.Element(ToastSize(width: 4, height: 1),
                                          ToastElement(text: "Testy Toasty"))
        let toast2 = ToastContent.Element(ToastSize(width: 4, height: 1),
                                          ToastElement(text: "Toasty Testy"))
        let toastContent = toast1 ||| toast1


        let toastA = Toast(content: toastContent,
                          presentationStyle: ToastPresentationStyle.Plain,
                          animationStyle: ToastAnimationStyle.Simple)

        let toastB = Toast(content: toast2,
                           presentationStyle: ToastPresentationStyle.Plain,
                           animationStyle: ToastAnimationStyle.Simple)

        toastQueue.queue(toastA)
        toastQueue.queue(toastB)
    }


}
