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

        let leftElementAttributes = TextAttribute(alignment: .Right)
                                .map { .ForegroundColor(UIColor.lightGrayColor()) }
                                .map { .BackgroundColor(UIColor.blackColor()) }

        let leftElement = ToastElement(text: "Left Toasty",
                                         attribute: leftElementAttributes)

        let leftContent = ToastContent(size: ToastSize(width: 5, height: 1),
                                          element: leftElement)

        let rightElementAttributes = TextAttribute(alignment: .Left)
                                .map { .ForegroundColor(UIColor.blackColor()) }
                                .map { .BackgroundColor(UIColor.lightGrayColor()) }

        let rightElement = ToastElement(text: "Right Toasty",
                                      attribute: rightElementAttributes)

        let rightContent = ToastContent(size: ToastSize(width: 5, height: 1),
                                      element: rightElement)


        let besideContent = leftContent ||| rightContent


        let toastA = Toast(content: besideContent,
                          presentationStyle: ToastPresentationStyle.Plain,
                          animationStyle: ToastAnimationStyle.Simple)



        let topElementAttributes = TextAttribute(alignment: .Center)
                                .map { .ForegroundColor(UIColor.blackColor()) }

        let topElement = ToastElement(text: "Top Toasty",
                                      attribute: topElementAttributes)

        let topContent = ToastContent(size: ToastSize(width: 10, height: 1),
                                      element: topElement)

        let bottomElementAttributes = TextAttribute(alignment: .Center)
                                .map { .ForegroundColor(UIColor.darkGrayColor()) }

        let bottomElement = ToastElement(text: "Bottom Toasty",
                                         attribute: bottomElementAttributes)

        let bottomContent = ToastContent(size: ToastSize(width: 10, height: 1),
                                          element: bottomElement)

        let stackContent = topContent --- bottomContent



        let toastB = Toast(content: stackContent,
                           presentationStyle: ToastPresentationStyle.RoundedRect,
                           animationStyle: ToastAnimationStyle.Simple)

        toastQueue.queue(toastA)
        toastQueue.queue(toastB)
    }
}
