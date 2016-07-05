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

        let attributes = TextAttribute(alignment: .Left)
            .map { .ForegroundColor(UIColor.blueColor()) }
            .map { .BackgroundColor(UIColor.cyanColor()) }

        let element = ContentElement(text: "Testy Toasty",
                                   attribute: attributes)

        let content = Content(size: ContentSize(width: 1, height: 1),
                                   element: element)
        
        let toast = Toast(content: content,
                          presentationStyle: .Plain,
                          animationStyle: .Simple)

        toastQueue.queue(toast)

        let leftElementAttributes = TextAttribute(alignment: .Right)
                                .map { .ForegroundColor(UIColor.lightGrayColor()) }
                                .map { .BackgroundColor(UIColor.blackColor()) }

        let leftElement = ContentElement(text: "Left Toasty",
                                         attribute: leftElementAttributes)

        let leftContent = Content(size: ContentSize(width: 1, height: 1),
                                          element: leftElement)

        let rightElementAttributes = TextAttribute(alignment: .Left)
                                .map { .ForegroundColor(UIColor.blackColor()) }
                                .map { .BackgroundColor(UIColor.lightGrayColor()) }

        let rightElement = ContentElement(text: "Right Toasty",
                                      attribute: rightElementAttributes)

        let rightContent = Content(size: ContentSize(width: 1, height: 1),
                                      element: rightElement)


        let besideContent = leftContent ||| rightContent


        let besideToast = Toast(content: besideContent,
                                presentationStyle: ToastPresentationStyle.Plain,
                                animationStyle: ToastAnimationStyle.Simple)

        toastQueue.queue(besideToast)


        let topElementAttributes = TextAttribute(alignment: .Center)
                                .map { .ForegroundColor(UIColor.blackColor()) }

        let topElement = ContentElement(text: "Top Toasty",
                                      attribute: topElementAttributes)

        let topContent = Content(size: ContentSize(width: 1, height: 1),
                                      element: topElement)

        let bottomElementAttributes = TextAttribute(alignment: .Center)
                                .map { .ForegroundColor(UIColor.darkGrayColor()) }

        let bottomElement = ContentElement(text: "Bottom Toasty",
                                         attribute: bottomElementAttributes)

        let bottomContent = Content(size: ContentSize(width: 1, height: 1),
                                          element: bottomElement)

        let stackContent = topContent --- bottomContent


        let stackToast = Toast(content: stackContent,
                           presentationStyle: ToastPresentationStyle.Plain,
                           animationStyle: ToastAnimationStyle.Simple)

        toastQueue.queue(stackToast)

    }
}
