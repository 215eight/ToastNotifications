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

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        let firstToast = Toast(text: "First Toast")
        let secondToast = Toast(text: "Second Toast")

        toastQueue.queue(firstToast)
        toastQueue.queue(secondToast)
    }
}
