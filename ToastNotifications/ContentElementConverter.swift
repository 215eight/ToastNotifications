//
//  ContentElementConverter.swift
//  ToastNotifications
//
//  Created by pman215 on 6/12/16.
//  Copyright © 2016 pman215. All rights reserved.
//

import Foundation
import UIKit

/**
 Converts a notification to a UI element
 */
func convert(element: ContentElement) -> UIView {

    switch element {

    case .empty:
        return UIView(frame: CGRect.zero)

    case .text(let text, let attribute):
        let attributes = convert(attribute: attribute)
        let attributedText = NSAttributedString(string: text,
                                                attributes: attributes)
        let label = UILabel(frame: CGRect.zero)
        label.attributedText = attributedText
        label.numberOfLines = 0

        if let backgroundColor = attributes[NSBackgroundColorAttributeName] as? UIColor{
            label.backgroundColor = backgroundColor
        }
        return label

    case .image(let name):
        let image = UIImage.nonNullImage(name: name)
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = image
        return imageView
    }
}

