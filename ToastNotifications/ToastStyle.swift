//
//  ToastStyle.swift
//  ToastNotifications
//
//  Created by pman215 on 6/4/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

enum ToastStyle {
    case plain
    case roundedRect

    func styleConfigurator() -> (UIView) -> Void {
        switch self {
        case .plain:
            return { (view) in
                print("Plain Style - Nothing Yet")
                view.backgroundColor = UIColor.orange
            }
        case .roundedRect:
            return { (view) in
                view.layer.cornerRadius = 10
                view.clipsToBounds = true
                view.backgroundColor = UIColor.lightGray
            }
        }
    }
    
}
