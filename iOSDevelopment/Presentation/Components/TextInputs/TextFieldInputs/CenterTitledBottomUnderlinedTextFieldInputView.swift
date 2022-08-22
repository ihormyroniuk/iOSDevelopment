//
//  CenterTitledBottomUnderlinedTextFieldInputView.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 11/29/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit
import ACoreAnimation

class CenterTitledBottomUnderlinedTextFieldInputView: AUIView, AUITextFieldTextInputView, AUIResponsiveTextInputView {

    // MARK: Elements

    let textField = UITextField()
    let titleTextLayer = ACATextLayerVerticalTextAlignmentCenter()
    let underlineLayer = CALayer()
    let descriptionLayer = ACATextLayerVerticalTextAlignmentCenter()

    // MARK: Setup

    override func setup() {
        super.setup()
        addSubview(textField)
        setupTextField()
        layer.addSublayer(titleTextLayer)
        setupPlaceholderTextLayer()
        layer.addSublayer(underlineLayer)
        setupUnderlineLayer()
        layer.addSublayer(descriptionLayer)
    }

    func setupTextField() {
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.tintColor = Colors.activeInput
    }

    func setupPlaceholderTextLayer() {
        titleTextLayer.contentsGravity = .center
        titleTextLayer.foregroundColor = Colors.inactiveInput.cgColor
        titleTextLayer.font = UIFont.systemFont(ofSize: 15.0).cgFont
        titleTextLayer.fontSize = 15
    }

    func setupUnderlineLayer() {
        underlineLayer.backgroundColor = Colors.inactiveInput.cgColor
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTextField()
        layoutPlaceholderTextLayer()
        layoutUnderlineLayer()
    }

    func layoutTextField() {
        let x: CGFloat = 0
        let width: CGFloat = bounds.size.width - x
        let height: CGFloat = 24
        let y: CGFloat = 17
        let frame = CGRect(x: x, y: y, width: width, height: height)
        textField.frame = frame
    }

    var placeholderTextLayerFrame: CGRect?
    func layoutPlaceholderTextLayer() {
        let anchorPoint = CGPoint(x: 0, y: 0)
        guard let placeholderTextLayerFrame = placeholderTextLayerFrame else {
            titleTextLayer.anchorPoint = anchorPoint
            let x: CGFloat = 0
            let width: CGFloat = bounds.size.width - x
            let height: CGFloat = 24
            let y: CGFloat = 17
            let frame = CGRect(x: x, y: y, width: width, height: height)
            titleTextLayer.frame = frame
            return
        }
        titleTextLayer.frame = placeholderTextLayerFrame
    }

    func layoutUnderlineLayer() {
        let x: CGFloat = 0
        let width: CGFloat = bounds.size.width - x
        let height: CGFloat = 1
        let y: CGFloat = bounds.size.height - 16 - height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        underlineLayer.frame = frame
    }

    // MARK: AUIResponsiveSubtextInputView

    func responsiveTextInputViewDidBeginEditingEmpty(animated: Bool) {
        var frame = titleTextLayer.frame
        frame.size.height = 16
        frame.origin.y = 0
        let foregroundColor = Colors.activeInput
        let font = UIFont.systemFont(ofSize: 12, weight: .medium)
        addTitleTextLayerAnimation(frame: frame, foregroundColor: foregroundColor, font: font)
        addUnderlineLayerBackgroundColorAnimation(foregroundColor)
    }

    func responsiveTextInputViewDidBeginEditingNonempty(animated: Bool) {
        var frame = titleTextLayer.frame
        frame.size.height = 16
        frame.origin.y = 0
        let foregroundColor = Colors.activeInput
        let font = UIFont.systemFont(ofSize: 12, weight: .medium)
        addTitleTextLayerAnimation(frame: frame, foregroundColor: foregroundColor, font: font)
        addUnderlineLayerBackgroundColorAnimation(foregroundColor)
    }

    func responsiveTextInputViewDidBecomeEmpty(animated: Bool) {

    }

    func responsiveTextInputViewDidBecomeNonEmpty(animated: Bool) {

    }

    func responsiveTextInputViewDidEndEditingEmpty(animated: Bool) {
        var frame = titleTextLayer.frame
        frame.size.height = 24
        frame.origin.y = 17
        let foregroundColor = Colors.inactiveInput
        let font = UIFont.systemFont(ofSize: 15)
        addTitleTextLayerAnimation(frame: frame, foregroundColor: foregroundColor, font: font)
        addUnderlineLayerBackgroundColorAnimation(foregroundColor)
    }

    func responsiveTextInputViewDidEndEditingNonempty(animated: Bool) {
        var frame = titleTextLayer.frame
        frame.size.height = 16
        frame.origin.y = 0
        let foregroundColor = Colors.inactiveInput
        let font = UIFont.systemFont(ofSize: 12)
        addTitleTextLayerAnimation(frame: frame, foregroundColor: foregroundColor, font: font)
        addUnderlineLayerBackgroundColorAnimation(foregroundColor)
    }

    // MARK: Animations

    let animationDuration: CFTimeInterval? = 0.2

    private var previousTitleTextLayerAnimationKey: String?
    func addTitleTextLayerAnimation(frame: CGRect, foregroundColor: UIColor, font: UIFont) {
        let bounds = CGRect(origin: .zero, size: frame.size)
        let boudsAnimation = CABasicAnimation(keyPath: CAPropertyAnimation.bounds)
        boudsAnimation.fromValue = titleTextLayer.bounds
        boudsAnimation.toValue = bounds
        let position = frame.origin
        let positionAnimation = CABasicAnimation(keyPath: CAPropertyAnimation.position)
        positionAnimation.fromValue = titleTextLayer.position
        positionAnimation.toValue = position
        let foregroundColorAnimation = CABasicAnimation(keyPath: CAPropertyAnimation.foregroundColor)
        foregroundColorAnimation.fromValue = titleTextLayer.foregroundColor
        foregroundColorAnimation.toValue = foregroundColor.cgColor
        let fontSize = font.pointSize
        let fontSizeAnimation = CABasicAnimation(keyPath: CAPropertyAnimation.fontSize)
        fontSizeAnimation.fromValue = titleTextLayer.fontSize
        fontSizeAnimation.toValue = fontSize
        let font = font.cgFont
        let fontAnimation = CABasicAnimation(keyPath: CAPropertyAnimation.font)
        fontAnimation.fromValue = titleTextLayer.font
        fontAnimation.toValue = font
        let animations = CAAnimationGroup()
        animations.animations = [boudsAnimation, positionAnimation, foregroundColorAnimation, fontSizeAnimation, fontAnimation]
        animations.isRemovedOnCompletion = false
        animations.fillMode = .forwards
        if let animationDuration = animationDuration {
            animations.duration = animationDuration
        }
        if let previousTitleTextLayerAnimationKey = previousTitleTextLayerAnimationKey {
            titleTextLayer.removeAnimation(forKey: previousTitleTextLayerAnimationKey)
        }
        previousTitleTextLayerAnimationKey = titleTextLayer.addAnimation(animations) { [weak self] (finished) in
            guard let self = self else { return }
            if let previousTitleTextLayerAnimationKey = self.previousTitleTextLayerAnimationKey {
                self.titleTextLayer.removeAnimation(forKey: previousTitleTextLayerAnimationKey)
            }
            self.previousTitleTextLayerAnimationKey = nil
            self.placeholderTextLayerFrame = CGRect(origin: position, size: bounds.size)
            self.titleTextLayer.frame = frame
            self.titleTextLayer.foregroundColor = foregroundColor.cgColor
            self.titleTextLayer.fontSize = fontSize
            self.titleTextLayer.font = font
        }
    }

    private var previousUnderlineLayerBackgroundColorAnimationKey: String?
    func addUnderlineLayerBackgroundColorAnimation(_ backgroundColor: UIColor) {
        let animation = CABasicAnimation(keyPath: CAPropertyAnimation.backgroundColor)
        animation.fromValue = underlineLayer.backgroundColor
        animation.toValue = backgroundColor.cgColor
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        if let animationDuration = animationDuration {
            animation.duration = animationDuration
        }
        if let previousUnderlineViewBackgroundColorAnimationKey = previousUnderlineLayerBackgroundColorAnimationKey {
            underlineLayer.removeAnimation(forKey: previousUnderlineViewBackgroundColorAnimationKey)
        }
        previousUnderlineLayerBackgroundColorAnimationKey = underlineLayer.addAnimation(animation) { [weak self] (finished) in
            guard let self = self else { return }
            if let previousUnderlineLayerBackgroundColorAnimationKey = self.previousUnderlineLayerBackgroundColorAnimationKey {
                self.underlineLayer.removeAnimation(forKey: previousUnderlineLayerBackgroundColorAnimationKey)
            }
            self.previousUnderlineLayerBackgroundColorAnimationKey = nil
            self.underlineLayer.backgroundColor = backgroundColor.cgColor
        }
    }

}
