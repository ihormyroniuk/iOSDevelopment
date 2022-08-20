//
//  TextFieldInputView.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/18/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit
import ACoreAnimation

class LeftIconedCenterTitledBottomUnderlinedTextFieldInputView: CenterTitledBottomUnderlinedTextFieldInputView {
    
    // MARK: Elements
    
    let iconLayer = CALayer()
    let iconLayerMask = CALayer()
    
    // MARK: Setup
    
    override func setup() {
        super.setup()
        layer.addSublayer(iconLayer)
        setupIconImageView()
    }
    
    func setupIconImageView() {
        iconLayerMask.contentsGravity = CALayerContentsGravity.resizeAspect
        iconLayer.mask = iconLayerMask
        iconLayer.backgroundColor = Colors.main.cgColor
    }

    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIconLayer()
    }
    
    func layoutIconLayer() {
        let width: CGFloat = 24
        let height: CGFloat = 23
        let x: CGFloat = 0
        let y: CGFloat = 17
        let frame = CGRect(x: x, y: y, width: width, height: height)
        iconLayer.frame = frame
        iconLayerMask.frame = iconLayer.bounds
    }

    override func layoutTextField() {
        let x: CGFloat = 33
        let width: CGFloat = bounds.size.width - x
        let height: CGFloat = 24
        let y: CGFloat = 17
        let frame = CGRect(x: x, y: y, width: width, height: height)
        textField.frame = frame
    }

    override func layoutPlaceholderTextLayer() {
        let anchorPoint = CGPoint(x: 0, y: 0)
        guard let placeholderTextLayerFrame = placeholderTextLayerFrame else {
            titleTextLayer.anchorPoint = anchorPoint
            let x: CGFloat = 33
            let width: CGFloat = bounds.size.width - x
            let height: CGFloat = 24
            let y: CGFloat = 17
            let frame = CGRect(x: x, y: y, width: width, height: height)
            titleTextLayer.frame = frame
            return
        }
        titleTextLayer.frame = placeholderTextLayerFrame
    }

    override func layoutUnderlineLayer() {
        let x: CGFloat = 33
        let width: CGFloat = bounds.size.width - x
        let height: CGFloat = 1
        let y: CGFloat = bounds.size.height - 16 - height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        underlineLayer.frame = frame
    }

    // MARK: AUIResponsiveSubtextInputView

    override func responsiveTextInputViewDidBeginEditingEmpty(animated: Bool) {
        super.responsiveTextInputViewDidBeginEditingEmpty(animated: animated)
        addIconImageViewTintColorAnimation(Colors.activeInput)
    }

    override func responsiveTextInputViewDidBeginEditingNonempty(animated: Bool) {
        super.responsiveTextInputViewDidBeginEditingNonempty(animated: animated)
        addIconImageViewTintColorAnimation(Colors.activeInput)
    }

    override func responsiveTextInputViewDidEndEditingEmpty(animated: Bool) {
        super.responsiveTextInputViewDidEndEditingEmpty(animated: animated)
        addIconImageViewTintColorAnimation(Colors.main)
    }

    override func responsiveTextInputViewDidEndEditingNonempty(animated: Bool) {
        super.responsiveTextInputViewDidEndEditingNonempty(animated: animated)
        addIconImageViewTintColorAnimation(Colors.main)
    }

    // MARK: Animations

    private var previousIconImageViewTintColorAnimationKey: String?
    func addIconImageViewTintColorAnimation(_ tintColor: UIColor) {
        let animation = CABasicAnimation(keyPath: CAPropertyAnimation.backgroundColor)
        let toValue = tintColor.cgColor
        animation.fromValue = iconLayer.contents
        animation.toValue = toValue
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        if let animationDuration = animationDuration {
            animation.duration = animationDuration
        }
        if let previousIconImageViewTintColorAnimationKey = self.previousIconImageViewTintColorAnimationKey {
            self.iconLayer.removeAnimation(forKey: previousIconImageViewTintColorAnimationKey)
        }
        previousIconImageViewTintColorAnimationKey = iconLayer.addAnimation(animation) { [weak self] (finished) in
            guard let self = self else { return }
            if let previousIconImageViewTintColorAnimationKey = self.previousIconImageViewTintColorAnimationKey {
                self.iconLayer.removeAnimation(forKey: previousIconImageViewTintColorAnimationKey)
            }
            self.previousIconImageViewTintColorAnimationKey = nil
            self.iconLayer.backgroundColor = tintColor.cgColor
        }
    }
    
}
