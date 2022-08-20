//
//  TextButton.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/18/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

class TextButton: AUIButton {
   
    // MARK: Setup
    
    override func setup() {
        super.setup()
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        self.setTitleColor(UIColor(red8Bits: 204, green8Bits: 0, blue8Bits: 0), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
