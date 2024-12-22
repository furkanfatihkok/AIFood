//
//  ForgotPasswordViewController.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit
import SnapKit

final class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Properties
    private let forgotPasswordViewModel: ForgotPasswordViewModel
    
    init(forgotPasswordViewModel: ForgotPasswordViewModel) {
        self.forgotPasswordViewModel = forgotPasswordViewModel
        super.init(nibName: nil, bundle: nil)
        forgotPasswordViewModel.emailDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private lazy var titleLabel: TitleLabel = {
        return TitleLabel(text: "Forgot password?", style: .title)
    }()
    
    private lazy var subtitleLabel: TitleLabel = {
        return TitleLabel(text: "Enter your email address and we’ll send you confirmation code to reset your password", style: .subtitle)
    }()
    
    private lazy var emailLabel: TitleLabel = {
        return TitleLabel(text: "Email Address", style: .email)
    }()
    
    private lazy var emailTextField: AuthTextField = {
        return AuthTextField(placeholder: "Enter Email")
    }()
    
    private lazy var emailErrorLabel: TitleLabel = {
        let label =  TitleLabel(text: "", style: .password)
        label.isHidden = true
        return label
    }()
    
    private lazy var continueButton: ActionButton = {
        let button = ActionButton(title: "Continue", type: .primary)
        button.delegate = self
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailErrorLabel)
        view.addSubview(continueButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing / 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(verticalSpacing * 1.5)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(verticalSpacing * 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
    }
}

// MARK: - ActionButtonProtocol
extension ForgotPasswordViewController: ActionButtonProtocol {
    func didTapPrimaryButton() {
        emailErrorLabel.isHidden = true
        
        let email = emailTextField.text ?? ""
        
        if email.isEmpty {
            emailErrorLabel.text = "Email field cannot be empty."
            emailErrorLabel.isHidden = false
        } else if !email.isValidEmail() {
            emailErrorLabel.text = "Please enter a valid email address."
            emailErrorLabel.isHidden = false
        } else {
            forgotPasswordViewModel.checkIfEmailExists(email: email)
        }
    }
    
    func didTapForgotPasswordButton() {}
    
    func didTapRegisterButton() {}
}

// MARK: - EmailValidationDelegate
extension ForgotPasswordViewController: EmailValidationDelegate {
    func emailExists() {
        let forgotSheetVC = ForgotSheetViewController(forgotPasswordViewModel: forgotPasswordViewModel)
        forgotSheetVC.email = emailTextField.text
        if let sheet = forgotSheetVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        forgotSheetVC.modalPresentationStyle = .pageSheet
        present(forgotSheetVC, animated: true)
    }
    
    func emailDoesNotExists() {
        emailErrorLabel.text = "The email is not registered."
        emailErrorLabel.isHidden = false
    }
    
    func didFailWithError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
