//
//  ContentConverterTests.swift
//  ToastNotifications
//
//  Created by pman215 on 6/11/16.
//  Copyright © 2016 pman215. All rights reserved.
//

@testable import ToastNotifications
import XCTest

class ContentConverterTests: XCTestCase {

    func testConvertContent() {

        let content = Content(text: "Toast")
        let contentView = convert(content: content)

        let labelConstraints = constraints(view: contentView.subviews.first!,
                                           superview: contentView,
                                           multipliers: (width: 1, height: 1, centerX: 1, centerY: 1))

        labelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }
    }

    func testConvertContentBeside() {

        let leftContent = Content(text: "Left")
        let rightContent = Content(text: "Right")
        let content = leftContent ||| rightContent
        let contentView = convert(content: content)

        let leftLabel: UILabel = contentView.subviews.filter { ($0 as? UILabel)?.text == "Left" }
                                                     .first! as! UILabel

        let leftLabelConstraints = constraints(view: leftLabel,
                                               superview: contentView,
                                               multipliers: (width: 0.5, height: 1, centerX: 0.5, centerY: 1))

        leftLabelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }

        let rightLabel: UILabel = contentView.subviews.filter { ($0 as? UILabel)?.text == "Right" }
                                                      .first! as! UILabel

        let rightLabelConstraints = constraints(view: rightLabel,
                                                superview: contentView,
                                                multipliers: (width: 0.5, height: 1, centerX: 1.5, centerY: 1))

        rightLabelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }
    }

    func testConvertContentStack() {

        let topContent = Content(text: "Top")
        let bottomContent = Content(text: "Bottom")
        let content = topContent --- bottomContent
        let contentView = convert(content: content)

        let topLabel: UILabel = contentView.subviews.filter { ($0 as? UILabel)?.text == "Top" }
                                                    .first! as! UILabel

        let topLabelConstraints = constraints(view: topLabel,
                                              superview: contentView,
                                              multipliers: (width: 1, height: 0.5, centerX: 1, centerY: 0.5))

        topLabelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }

        let bottomLabel: UILabel = contentView.subviews.filter { ($0 as? UILabel)?.text == "Bottom" }
                                                       .first! as! UILabel

        let bottomLabelConstraints = constraints(view: bottomLabel,
                                                 superview: contentView,
                                                 multipliers: (width: 1, height: 0.5, centerX: 1, centerY: 1.5))

        bottomLabelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }
    }

    func testConvertComposedContent() {
        let leftTop = Content(size: ContentSize(width: 8, height: 1),
                              element: ContentElement(text: "leftTop"))
        let leftBottom = Content(size: ContentSize(width: 8, height: 1),
                                 element: ContentElement(text: "leftBottom"))
        let right = Content(size: ContentSize(width: 2, height: 2),
                            element: ContentElement(imageName: "test.png"))

        let content = (leftTop --- leftBottom) ||| right

        let contentView = convert(content: content)

        let leftTopLabel: UILabel = contentView.subviews.filter { ($0 as? UILabel)?.text == "leftTop" }
                                                        .first! as! UILabel
        let leftBottomLabel: UILabel = contentView.subviews.filter { ($0 as? UILabel)?.text == "leftBottom" }
                                                           .first! as! UILabel
        let rightImageView: UIImageView = contentView.subviews.filter { $0 is UIImageView }
                                                              .first! as! UIImageView

        let leftTopLabelConstraints = constraints(view: leftTopLabel,
                                                  superview: contentView,
                                                  multipliers: (width: 0.8, height: 0.5, centerX: 0.8, centerY: 0.5))

        leftTopLabelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }

        let leftBottomLabelConstraints = constraints(view: leftBottomLabel,
                                                     superview: contentView,
                                                     multipliers: (width: 0.8, height: 0.5, centerX: 0.8, centerY: 1.5))

        leftBottomLabelConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }

        let rightImageViewConstraints = constraints(view: rightImageView,
                                                    superview: contentView,
                                                    multipliers: (width: 0.2, height: 1.0, centerX: 1.8, centerY: 1.0))

        rightImageViewConstraints.forEach {
            XCTAssertTrue($0.present(in: contentView.constraints),
                          "Constraint \($0) not found")
        }
    }

    func constraints(view: UIView,
                     superview: UIView,
                     multipliers: (width: CGFloat, height: CGFloat, centerX: CGFloat, centerY: CGFloat)) -> [NSLayoutConstraint] {

        return [(view, superview, NSLayoutAttribute.width, multipliers.width),
                (view, superview, NSLayoutAttribute.height, multipliers.height),
                (view, superview, NSLayoutAttribute.centerX, multipliers.centerX),
                (view, superview, NSLayoutAttribute.centerY, multipliers.centerY)].map {
                    return NSLayoutConstraint(item: $0.0,
                                              attribute: $0.2,
                                              relatedBy: .equal,
                                              toItem: $0.1,
                                              attribute: $0.2,
                                              multiplier: $0.3,
                                              constant: 0)
        }
    }
}
