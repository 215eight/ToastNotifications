//
//  ToastElementConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 Converts a toast element to a UI element with the specified frame
 */
func convert(element: ToastElement, frame: CGRect) -> UIView {

    switch element {

    case .Text(let text, let attribute):
        let attributes = convert(attribute)
        let attributedText = NSAttributedString(string: text,
                                                attributes: attributes)
        let label = UILabel(frame: frame)
        label.attributedText = attributedText

        if let backgroundColor = attributes[NSBackgroundColorAttributeName] as? UIColor{
            label.backgroundColor = backgroundColor
        }
        return label

    case .Image(let name):
        let image = UIImage.nonNullImage(name)
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        return imageView
    }
}
