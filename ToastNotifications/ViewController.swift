//
//  ViewController.swift
//  ToastNotifications
//
//  Created by Erick Andrade on 6/1/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var toastQueue: ToastQueue = {
        return ToastQueue(viewController: self)
    }()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let toast1 = ToastContent.Element(ToastSize(width: 4, height: 1), .Text("Testy Toasty"))
        let toast2 = ToastContent.Element(ToastSize(width: 4, height: 1), .Text("Toasty Testy"))
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
