//
//  ScreenViewWithDefaultStatusBarAndDefaultNavigationBar.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/18/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit

class ScreenViewWithDefaultStatusBarAndDefaultNavigationBar: ScreenViewWithNavigationBar {
    
    // MARK: Elements
    
    let navigationBarSeparatorView = UIView()
    
    // MARK: Setup
    
    override func setup() {
        super.setup()
        setupNavigationBarSeparatorView()
        navigationBarView.addSubview(navigationBarSeparatorView)
        setupNavigationBarView()
    }
    
    override func setupStatusBarView() {
        super.setupStatusBarView()
        statusBarView.backgroundColor = UIColor(red8Bits: 5, green8Bits: 5, blue8Bits: 5, alpha: 0.05)
    }
    
    override func setupNavigationBarView() {
        super.setupNavigationBarView()
        navigationBarView.backgroundColor = UIColor(red8Bits: 5, green8Bits: 5, blue8Bits: 5, alpha: 0.05)
    }
    
    func setupNavigationBarSeparatorView() {
        navigationBarSeparatorView.backgroundColor = UIColor(red8Bits: 234, green8Bits: 234, blue8Bits: 234, alpha: 1)
    }
    
    // MARK: AutoLayout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutNavigationBarSeparatorView()
    }
    
    func layoutNavigationBarSeparatorView() {
        let height: CGFloat = 1
        let x: CGFloat = 0
        let y: CGFloat = navigationBarView.frame.size.height - height
        let width: CGFloat = navigationBarView.frame.size.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        navigationBarSeparatorView.frame = frame
    }
    
}
