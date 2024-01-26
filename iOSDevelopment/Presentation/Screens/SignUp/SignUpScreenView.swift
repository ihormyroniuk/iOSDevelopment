import UIKit
import AUIKit

class SignUpScreenView: ScreenViewWithDefaultStatusBarAndDefaultNavigationBar {

    // MARK: Elements

    let cancelButton = TextButton()
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let firstNameTextFieldInputView = LeftIconedCenterTitledBottomUnderlinedTextFieldInputView()
    let lastNameTextFieldInputView = CenterTitledBottomUnderlinedTextFieldInputView()
    let emailTextFieldInputView = LeftIconedCenterTitledBottomUnderlinedTextFieldInputView()
    let passwordTextFieldInputView = LeftIconedCenterTitledRightButtonedBottomUnderlinedTextFieldInputView(button: ImageButton())
    var securePasswordButton: UIButton { return passwordTextFieldInputView.button }
    let phoneTextFieldInputView = LeftIconedCenterTitledBottomUnderlinedTextFieldInputView()
    let birthdayTextFieldInputView = LeftIconedCenterTitledBottomUnderlinedTextFieldInputView()
    let termsAndConditionsInteractiveLabel = AUIInteractiveLabel()
    let signUpButton = FilledTextButton()

    // MARK: Setup

    override func setup() {
        super.setup()
        backgroundColor = .white
        navigationBarView.addSubview(cancelButton)
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        setupTitleLabel()
        scrollView.addSubview(firstNameTextFieldInputView)
        setupFirstNameTextFieldInputView()
        scrollView.addSubview(lastNameTextFieldInputView)
        scrollView.addSubview(emailTextFieldInputView)
        setupEmailTextFieldInputView()
        scrollView.addSubview(passwordTextFieldInputView)
        setupPasswordTextFieldInputView()
        scrollView.addSubview(phoneTextFieldInputView)
        setupPhoneTextFieldInputView()
        scrollView.addSubview(birthdayTextFieldInputView)
        scrollView.addSubview(termsAndConditionsInteractiveLabel)
        setupTermsAndConditionsInteractiveLabel()
        scrollView.addSubview(signUpButton)
        setupBirthdayTextFieldInputView()
    }

    func setupTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(red8Bits: 51, green8Bits: 51, blue8Bits: 51)
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }

    func setupFirstNameTextFieldInputView() {
        let iconImage = UIImage(named: "sign_up_name")
        firstNameTextFieldInputView.iconLayerMask.contents = iconImage?.cgImage
    }

    func setupEmailTextFieldInputView() {
        let iconImage = UIImage(named: "sign_up_email")
        emailTextFieldInputView.iconLayerMask.contents = iconImage?.cgImage
    }

    func setupPasswordTextFieldInputView() {
        let iconImage = UIImage(named: "sign_up_password")
        passwordTextFieldInputView.iconLayerMask.contents = iconImage?.cgImage
        passwordTextFieldInputView.button.setImage(UIImage(named: "sign_up_password_secure"), for: .normal)
    }

    func setupPhoneTextFieldInputView() {
        let iconImage = UIImage(named: "sign_up_phone")
        phoneTextFieldInputView.iconLayerMask.contents = iconImage?.cgImage
    }

    func setupBirthdayTextFieldInputView() {
        birthdayTextFieldInputView.textField.tintColor = .clear
        let datePicker = UIDatePicker()
        birthdayTextFieldInputView.textField.inputView = datePicker
        let iconImage = UIImage(named: "sign_up_birthday")
        birthdayTextFieldInputView.iconLayerMask.contents = iconImage?.cgImage
    }

    func setupTermsAndConditionsInteractiveLabel() {
        termsAndConditionsInteractiveLabel.numberOfLines = 0
        termsAndConditionsInteractiveLabel.lineBreakMode = .byWordWrapping
    }

    // MARK: Layout

    var keyboardFrame: CGRect?

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCancelButton()
        layoutTitleLabel()
        layoutFirstNameTextFieldInputView()
        layoutLastNameTextFieldInputView()
        layoutEmailTextFieldInputView()
        layoutPhoneTextFieldInputView()
        layoutPasswordTextFieldInputView()
        layoutBirthdayTextFieldInputView()
        layoutTermsAndConditionsLabel()
        layoutSignUpButton()
        layoutScrollView()
    }

    func layoutCancelButton() {
        let leftPadding: CGFloat = 17
        let navigationBarWidth = self.navigationBarView.bounds.width
        let maximumPossibleWidth = navigationBarWidth - 2 * leftPadding
        let navigationBarHeight = self.navigationBarView.bounds.height
        let prefferedSize = cancelButton.sizeThatFits(CGSize(width: maximumPossibleWidth, height: navigationBarHeight))
        let width: CGFloat = prefferedSize.width
        let x = leftPadding
        let height: CGFloat = prefferedSize.height
        let y: CGFloat = (navigationBarHeight - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        cancelButton.frame = frame
    }

    func layoutTitleLabel() {
        let x: CGFloat = 24
        let y: CGFloat = 24
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 32
        let frame = CGRect(x: x, y: y, width: width, height: height)
        titleLabel.frame = frame
    }

    func layoutFirstNameTextFieldInputView() {
        let x: CGFloat = 24
        let y: CGFloat = titleLabel.frame.origin.y + titleLabel.frame.size.height + 16
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        firstNameTextFieldInputView.frame = frame
    }

    func layoutLastNameTextFieldInputView() {
        let x: CGFloat = 56
        let y: CGFloat = firstNameTextFieldInputView.frame.origin.y + firstNameTextFieldInputView.frame.size.height
        let width: CGFloat = bounds.size.width - x - 24
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        lastNameTextFieldInputView.frame = frame
    }

    func layoutEmailTextFieldInputView() {
        let x: CGFloat = 24
        let y: CGFloat = lastNameTextFieldInputView.frame.origin.y + lastNameTextFieldInputView.frame.size.height
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        emailTextFieldInputView.frame = frame
    }

    func layoutPhoneTextFieldInputView() {
        let x: CGFloat = 24
        let y: CGFloat = emailTextFieldInputView.frame.origin.y + emailTextFieldInputView.frame.size.height
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        phoneTextFieldInputView.frame = frame
    }

    func layoutPasswordTextFieldInputView() {
        let x: CGFloat = 24
        let y: CGFloat = phoneTextFieldInputView.frame.origin.y + phoneTextFieldInputView.frame.size.height
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        passwordTextFieldInputView.frame = frame
    }

    func layoutBirthdayTextFieldInputView() {
        let x: CGFloat = 24
        let y: CGFloat = passwordTextFieldInputView.frame.origin.y + passwordTextFieldInputView.frame.size.height
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 64
        let frame = CGRect(x: x, y: y, width: width, height: height)
        birthdayTextFieldInputView.frame = frame
    }

    func layoutTermsAndConditionsLabel() {
        let x: CGFloat = 24
        let y: CGFloat = birthdayTextFieldInputView.frame.origin.y + birthdayTextFieldInputView.frame.size.height + 24
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = termsAndConditionsInteractiveLabel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        termsAndConditionsInteractiveLabel.frame = frame
    }

    func layoutSignUpButton() {
        let x: CGFloat = 24
        let y: CGFloat = termsAndConditionsInteractiveLabel.frame.origin.y + termsAndConditionsInteractiveLabel.frame.size.height + 24
        let width: CGFloat = bounds.size.width - x * 2
        let height: CGFloat = 40
        let frame = CGRect(x: x, y: y, width: width, height: height)
        signUpButton.frame = frame
    }

    func layoutScrollView() {
        let x: CGFloat = 0
        let y: CGFloat = navigationBarView.frame.origin.y + navigationBarView.frame.size.height
        let width: CGFloat = bounds.size.width
        var height = bounds.size.height - y
        if let keyboardFrame = self.keyboardFrame {
            height -= (bounds.height - keyboardFrame.origin.y)
        }
        let frame = CGRect(x: x, y: y, width: width, height: height)
        scrollView.frame = frame
        let contentSizeWidth: CGFloat = bounds.width
        let contentSizeHeight: CGFloat = signUpButton.frame.origin.y + signUpButton.frame.size.height + 24
        scrollView.contentSize = CGSize(width: contentSizeWidth, height: contentSizeHeight)
    }

    // MARK: Events

    func keyboardDidShow(_ keyboardFrame: CGRect) {
        self.keyboardFrame = keyboardFrame
        layoutScrollView()
        layoutIfNeeded()
    }

    func keyboardWillHide(_ keyboardFrame: CGRect) {
        self.keyboardFrame = keyboardFrame
        layoutScrollView()
        layoutIfNeeded()
    }

    // MARK: Setters

    func setAgreeTermsAndConditionsText(agree: String, termsAndConditions: (String, String)) {
        let termsAndConditionsAttributes: [NSAttributedString.Key: Any] =
            [.font: UIFont.systemFont(ofSize: 12),
             .foregroundColor: UIColor(red8Bits: 204, green8Bits: 0, blue8Bits: 0),
             .interaction: termsAndConditions.1]
        let agreeTermsAndConditionsAttributes: [NSAttributedString.Key: Any] =
            [.font: UIFont.systemFont(ofSize: 12),
             .foregroundColor: UIColor(red8Bits: 102, green8Bits: 102, blue8Bits: 102)]
        let agreeTermsAndConditionsString = NSMutableAttributedString(string: agree, attributes: agreeTermsAndConditionsAttributes)
        guard let range = agree.range(of: termsAndConditions.0) else { return }
        let nsRange = NSRange(range, in: agreeTermsAndConditionsString.string)
        agreeTermsAndConditionsString.addAttributes(termsAndConditionsAttributes, range: nsRange)
        self.termsAndConditionsInteractiveLabel.attributedText = agreeTermsAndConditionsString
    }

}
