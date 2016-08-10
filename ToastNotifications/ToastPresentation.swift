//
//  ToastPresentation.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

struct ToastPresentation {

    let style: ToastStyle
    let position: ToastPosition
    let size: ToastSize

    func configure(with view: UIView) {
        style.styleConfigurator()(view)
        position.positionConfigurator()(view)
        size.sizeConfigurator()(view)
    }
}

extension ToastPresentation {

    static func defaultPresentation() -> ToastPresentation {
        let style = ToastStyle.Plain
        let position = ToastPosition.Center
        let size = ToastSize.Relative(xRatio: 0.9, yRatio: 0.1)

        return ToastPresentation(style: style,
                                 position: position,
                                 size: size)
    }
}