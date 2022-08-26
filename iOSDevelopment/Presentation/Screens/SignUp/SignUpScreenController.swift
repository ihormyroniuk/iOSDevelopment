//
//  SignUpScreenController.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 11/20/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit
import AFoundation

class SignUpScreenController: UIViewController, AUITextFieldControllerDidBeginEditingObserver {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Localization

    let localization = CompositeLocalizer(textLocalization: TableNameBundleTextLocalizer(tableName: "SignUpScreenStrings", bundle: Bundle.main))

    // MARK: View
    
    override func loadView() {
        view = SignUpScreenView()
    }

    private var screenView: SignUpScreenView! {
        return self.view as? SignUpScreenView
    }

    // MARK: Elements

    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let cancelButtonController = AUIEmptyButtonController()
    private let firstNameTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let firstNameTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let lastNameTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let lastNameTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let emailTextFieldController = AUIEmptyTextFieldController()
    private let emailTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let passwordTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let passwordTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let securePasswordButtonController = AUIEmptyButtonController()
    private let phoneTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let phoneTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let birthdayTextFieldController = AUIEmptyTextFieldController()
    private let birthdayTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let birthdayDatePickerController = AUIEmptyDateTimePickerController()
    private let termsAndConditionsInteractiveTextIdentifier = "TermsAndConditions"
    private let signUpButtonController = AUIEmptyButtonController()

    // MARK: Setup

    func setup() {
        setupTapGestureRecognizer()
        setupCancelButtonController()
        setupFirstNameTextFieldInputView()
        setupLastNameTextFieldInputView()
        setupEmailTextFieldInputView()
        setupPasswordTextFieldInputView()
        setupPhoneTextFieldInputView()
        setupBirthdayTextFieldInputView()
        setupSignInButtonController()
        setupTermsAndConditionsInteractiveLabel()
        setContent()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    func setupTapGestureRecognizer() {
        screenView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureRecognizerAction))
    }

    func setupCancelButtonController() {
        cancelButtonController.button = screenView.cancelButton
        cancelButtonController.touchUpInside = { [weak self] in
            guard let self = self else { return }
            self.cancel()
        }
    }

    func setupFirstNameTextFieldInputView() {
        firstNameTextFieldController.returnKeyType = .next
        firstNameTextFieldController.keyboardType = .default
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 16)
        firstNameTextFieldController.textInputValidator = textInputValidator
        firstNameTextFieldInputView.textFieldController = firstNameTextFieldController
        firstNameTextFieldInputView.view = screenView.firstNameTextFieldInputView
        firstNameTextFieldController.didTapReturnKey = { [weak self] in
            guard let self = self else { return true }
            self.lastNameTextFieldInputView.textFieldController?.becomeFirstResponder()
            return false
        }
    }

    func setupLastNameTextFieldInputView() {
        lastNameTextFieldController.returnKeyType = .next
        lastNameTextFieldController.keyboardType = .default
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 24)
        lastNameTextFieldController.textInputValidator = textInputValidator
        lastNameTextFieldInputView.textFieldController = lastNameTextFieldController
        lastNameTextFieldInputView.view = screenView.lastNameTextFieldInputView
        lastNameTextFieldInputView.didTapReturnKey = { [weak self] in
            guard let self = self else { return true }
            self.emailTextFieldInputView.textFieldController?.becomeFirstResponder()
            return false
        }
    }

    func setupEmailTextFieldInputView() {
        emailTextFieldController.returnKeyType = .next
        emailTextFieldController.keyboardType = .emailAddress
        emailTextFieldInputView.textFieldController = emailTextFieldController
        emailTextFieldInputView.view = screenView.emailTextFieldInputView
        emailTextFieldInputView.didTapReturnKey = { [weak self] in
            guard let self = self else { return true }
            self.phoneTextFieldInputView.textFieldController?.becomeFirstResponder()
            return false
        }
    }

    func setupPasswordTextFieldInputView() {
        passwordTextFieldController.returnKeyType = .next
        passwordTextFieldController.keyboardType = .default
        passwordTextFieldController.autocorrectionType = .no
        passwordTextFieldController.isSecureTextEntry = true
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 64)
        passwordTextFieldController.textInputValidator = textInputValidator
        passwordTextFieldInputView.textFieldController = passwordTextFieldController
        passwordTextFieldInputView.view = screenView.passwordTextFieldInputView
        passwordTextFieldInputView.didTapReturnKey = { [weak self] in
            guard let self = self else { return true }
            self.birthdayTextFieldInputView.textFieldController?.becomeFirstResponder()
            return false
        }
        securePasswordButtonController.button = screenView.securePasswordButton
        securePasswordButtonController.touchUpInside = { [weak self] in
            guard let self = self else { return }
            self.securePassword()
        }
    }

    func setupPhoneTextFieldInputView() {
        phoneTextFieldController.keyboardType = .asciiCapableNumberPad
        phoneTextFieldInputView.textFieldController = phoneTextFieldController
        phoneTextFieldInputView.view = screenView.phoneTextFieldInputView
        phoneTextFieldInputView.didTapReturnKey = { [weak self] in
            guard let self = self else { return true }
            self.passwordTextFieldInputView.textFieldController?.becomeFirstResponder()
            return false
        }
    }

    func setupBirthdayTextFieldInputView() {
        birthdayTextFieldController.inputViewController = self.birthdayDatePickerController
        birthdayTextFieldController.addDidBeginEditingObserver(self)
        birthdayDatePickerController.maximumDate = Date()
        birthdayDatePickerController.mode = .date
        birthdayDatePickerController.valueChanged = {[weak self] in
            guard let self = self else { return }
            self.setSelectedBirtday()
        }
        birthdayTextFieldInputView.textFieldController = birthdayTextFieldController
        birthdayTextFieldInputView.view = screenView.birthdayTextFieldInputView
    }

    func setupTermsAndConditionsInteractiveLabel() {
        screenView.termsAndConditionsInteractiveLabel.addTarget(self, action: #selector(termsAndConditionsInteractiveLabelTouchUpInside), for: .touchUpInside)
    }

    func setupSignInButtonController() {
        signUpButtonController.button = screenView.signUpButton
        signUpButtonController.touchUpInside = { [weak self] in
            guard let self = self else { return }
            self.signUp()
        }
    }

    // MARK: Events

    @objc func keyboardDidShow(_ notification: Notification) {
        if let keyboardFrameValue: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            screenView.keyboardDidShow(keyboardFrame)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrameValue: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            screenView.keyboardWillHide(keyboardFrame)
        }
    }

    func textFieldControllerDidBeginEditing(_ textFieldController: AUITextFieldController) {
        if self.birthdayTextFieldInputView.textFieldController === textFieldController {
            setSelectedBirtday()
        }
    }

    // MARK: Actions

    @objc func tapGestureRecognizerAction() {
        screenView.endEditing(true)
    }

    @objc func termsAndConditionsInteractiveLabelTouchUpInside(_ kk: AUIInteractiveLabel, _ interactiveTextIdentifier: AUIInteractiveLabelEvent) {
        print(interactiveTextIdentifier.interaction)
    }

    func cancel() {
        print("cancel")
    }

    func securePassword() {
        if passwordTextFieldInputView.textFieldController?.isSecureTextEntry == true {
            passwordTextFieldInputView.textFieldController?.isSecureTextEntry = false
        } else {
            passwordTextFieldInputView.textFieldController?.isSecureTextEntry = true
        }
    }

    func setSelectedBirtday() {
        let birthday = self.birthdayDatePickerController.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let birthdayString = dateFormatter.string(from: birthday)
        birthdayTextFieldInputView.textFieldController?.text = birthdayString
    }

    func signUp() {
        let firstName = firstNameTextFieldController.text
        let lastName = lastNameTextFieldController.text
        let email = emailTextFieldController.text
        let phone = phoneTextFieldController.text
        let password = passwordTextFieldController.text
        let birthday = (birthdayTextFieldController.text?.isEmpty ?? true) ? nil : birthdayDatePickerController.date

        print("First Name: \(String(describing: firstName))")
        print("Last Name: \(String(describing: lastName))")
        print("Email: \(String(describing: email))")
        print("Phone: \(String(describing: phone))")
        print("Password: \(String(describing: password))")
        print("Birthday: \(String(describing: birthday))")
    }

    // MARK: Content

    func setContent() {
        cancelButtonController.title = localization.localizeText("cancelButtonTitle")
        screenView.titleLabel.text = localization.localizeText("screenTitle")
        screenView.firstNameTextFieldInputView.titleTextLayer.string = localization.localizeText("firstNameInputViewTitlePlaceholder")
        screenView.lastNameTextFieldInputView.titleTextLayer.string = localization.localizeText("lastNameInputViewTitlePlaceholder")
        screenView.emailTextFieldInputView.titleTextLayer.string = localization.localizeText("emailInputViewTitlePlaceholder")
        screenView.passwordTextFieldInputView.titleTextLayer.string = localization.localizeText("passwordInputViewTitlePlaceholder")
        screenView.phoneTextFieldInputView.titleTextLayer.string = localization.localizeText("phoneInputViewTitlePlaceholder")
        screenView.birthdayTextFieldInputView.titleTextLayer.string = localization.localizeText("birthdayInputViewTitlePlaceholder")
        screenView.setAgreeTermsAndConditionsText(agree: localization.localizeText("agreeTermsAndConditions", localization.localizeText("referenceTermsAndConditions") ?? "") ?? "", termsAndConditions: (localization.localizeText("referenceTermsAndConditions") ?? "", termsAndConditionsInteractiveTextIdentifier))
        signUpButtonController.title = localization.localizeText("signInButtonTitle")
    }

}
