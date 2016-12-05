//
//  Style.swift
//  ToastNotifications
//
//  Created by pman215 on 6/4/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

struct Style {

    private let configurator: (UIView) -> Void
    
    init(configurator: @escaping (UIView) -> Void) {
        self.configurator = configurator
    }

    init() {
        self.init { (view) in
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            view.backgroundColor = UIColor.white.withAlphaComponent(0.8)   
        }
    }

    func configure(view: UIView) {
        configurator(view)
    }
}

