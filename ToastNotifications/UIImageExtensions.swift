//
//  UIImageExtensions.swift
//  ToastNotifications
//
//  Created by PartyMan on 6/11/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
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
