//
//  FilledButton.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/18/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

class FilledTextButton: AUIButton {
    
    // MARK: Elements
    
    let backgroundLayer = CALayer()
    
    // MARK: Setup
    
    override func setup() {
        super.setup()
        setupTitleLabel()
        layer.insertSublayer(backgroundLayer, at: 0)
        setupBackgroundLayer()
    }
    
    func setupBackgroundLayer() {
        backgroundLayer.backgroundColor = UIColor(red8Bits: 204, green8Bits: 0, blue8Bits: 0).cgColor
        backgroundLayer.masksToBounds = true
    }
    
    func setupTitleLabel() {
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackgroundLayer()
    }
    
    func layoutBackgroundLayer() {
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = 8
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
