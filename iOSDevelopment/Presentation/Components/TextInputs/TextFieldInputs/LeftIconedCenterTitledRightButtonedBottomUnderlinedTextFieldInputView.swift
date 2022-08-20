//
//  LeftIconedCenterTitledRightButtonedBottomUnderlinedTextFieldInputView.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 11/27/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

class LeftIconedCenterTitledRightButtonedBottomUnderlinedTextFieldInputView: LeftIconedCenterTitledBottomUnderlinedTextFieldInputView {

    // MARK: Elements

    let button: UIButton

    // MARK: Initializer

    init(frame: CGRect = .zero, button: UIButton = UIButton()) {
        self.button = button
        super.init(frame: frame)
    }

    // MARK: Setup

    override func setup() {
        super.setup()
        self.addSubview(button)
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutButton()
    }

    override func layoutTextField() {
        let x: CGFloat = 33
        let width: CGFloat = bounds.size.width - x - 24
        let height: CGFloat = 24
        let y: CGFloat = 17
        let frame = CGRect(x: x, y: y, width: width, height: height)
        textField.frame = frame
    }

    func layoutButton() {
        let width: CGFloat = 24
        let x: CGFloat = bounds.width - width
        let y: CGFloat = 17
        let height: CGFloat = 23
        let frame = CGRect(x: x, y: y, width: width, height: height)
        button.frame = frame
    }
}
