//
//  OTPViewController.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit

final class OTPViewController: UIViewController {
    
    // MARK: - Properties
    private let email: String
    private let forgotPasswordViewModel: ForgotPasswordViewModel
    
    init(email: String, forgotPasswordViewModel: ForgotPasswordViewModel = ForgotPasswordViewModel(delegate: nil, authManager: FirebaseAuthManager.shared)) {
        self.email = email
        self.forgotPasswordViewModel = forgotPasswordViewModel
        super.init(nibName: nil, bundle: nil)
        self.forgotPasswordViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: UI Components
    private lazy var navigationBar: NavigationBar = {
        let navBar = NavigationBar(
            title: "OTP",
            leftButtonIcon: UIImage(systemName: "chevron.left")
        )
        navBar.delegate = self
        return navBar
    }()
    
    private lazy var titleLabel: TitleLabel = {
        return TitleLabel(text: "Email verification", style: .title)
    }()
    
    private lazy var subtitle: TitleLabel = {
        return TitleLabel(text: "Enter the verification code we send you on:\n\(email)", style: .subtitle)
    }()
    
    private lazy var otpInputView: OTPInputView = {
        let otpView = OTPInputView(numberOfFields: 4)
        otpView.delegate = self
        return otpView
    }()
    
    private lazy var footerLabel: TitleLabel = {
        return  TitleLabel(text: "Didn't receive code?", style: .footer)
    }()
    
    private lazy var resendButton: ActionButton = {
        let button = ActionButton(title: "Resend", type: .register)
        button.delegate = self
        return button
    }()
    
    // TODO: TIMER EKLE
    
    private lazy var continueButton: ActionButton = {
        let button = ActionButton(title: "Continue", type: .primary)
        button.delegate = self
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTapped()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(titleLabel)
        view.addSubview(subtitle)
        view.addSubview(otpInputView)
        view.addSubview(footerLabel)
        view.addSubview(resendButton)
        view.addSubview(continueButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing / 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        otpInputView.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(verticalSpacing * 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.top.equalTo(otpInputView.snp.bottom).offset(verticalSpacing)
            make.centerX.equalToSuperview().offset(-40)
        }
        
        resendButton.snp.makeConstraints { make in
            make.centerY.equalTo(footerLabel)
            make.leading.equalTo(footerLabel.snp.trailing).offset(2)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(verticalSpacing * 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
    }
}

// MARK: - NavigationBarProtocol
extension OTPViewController: NavigationBarProtocol {
    func didTapLeftButton() {
        dismiss(animated: true)
    }
    
    func didTapRightButton() {}
}

// MARK:- OTPInputViewProtocol
extension OTPViewController: OTPInputViewProtocol {
    func didEnterCode(_ code: String) {
        print("Entered OTP: \(code)")
    }
}

// MARK: - ActionButtonProtocol
extension OTPViewController: ActionButtonProtocol {
    func didTapPrimaryButton() {
        print("Continue button tapped")
    }
    
    func didTapForgotPasswordButton() {}
    
    func didTapRegisterButton() {}
}

// MARK: - ForgotPasswordViewModelDelegate
extension OTPViewController: ForgotPasswordViewModelDelegate {
    func emailExists() {}
    
    func emailDoesNotExists() {}
    
    func didFailWithError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
