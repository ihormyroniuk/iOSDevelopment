//
//  ImageButton.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 11/29/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

class ImageButton: AUIButton {

    // MARK: Setup

    override func setup() {
        super.setup()
        adjustsImageWhenHighlighted = false
    }

    // MARK: States

    override var isHighlighted: Bool {
        willSet {
            if newValue {
                alpha = 0.6
            } else {
                alpha = 1
            }
        }
    }

}
