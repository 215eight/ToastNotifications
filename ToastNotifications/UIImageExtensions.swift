//
//  UIImageExtensions.swift
//  ToastNotifications
//
//  Created by pman215 on 6/11/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    static func nonNullImage(name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            return UIImage()
        }
        return image
    }
}
