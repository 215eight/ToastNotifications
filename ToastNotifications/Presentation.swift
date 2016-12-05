//
//  Appearance.swift
//  ToastNotifications
//
//  Created by pman215 on 8/8/16.
//  Copyright © 2016 Erick Andrade. All rights reserved.
//

import UIKit

struct Appearance {

    let style: Style
    let position: Position
    let size: Size

    init() {
        let style = Style()
        let position = Position.center
        let size = Size.relative(xRatio: 0.9, yRatio: 0.1)

        self.init(style: style,
                  position: position,
                  size: size)
    }

    init(style: Style, position: Position, size: Size) {
        self.style = style
        self.position = position
        self.size = size
    }

    func configure(with view: UIView) {
        style.configure(view: view)
        position.addPositionConstraints(to: view)
        size.addSizeConstraints(to: view)
    }
}
