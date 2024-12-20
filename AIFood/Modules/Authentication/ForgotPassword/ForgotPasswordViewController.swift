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
    
    init(forgotPasswordViewModel: ForgotPasswordViewModel = ForgotPasswordViewModel(delegate: nil, authManager: FirebaseAuthManager.shared)) {
        self.forgotPasswordViewModel = forgotPasswordViewModel
        super.init(nibName: nil, bundle: nil)
        self.forgotPasswordViewModel.delegate = self
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
        guard let email = emailTextField.text, !email.isEmpty else { return }
        
        forgotPasswordViewModel.checkIfEmailExists(email: email)
    }
    
    func didTapForgotPasswordButton() {}
    
    func didTapRegisterButton() {}
}

// MARK: - ForgotPasswordViewModelDelegate
extension ForgotPasswordViewController: ForgotPasswordViewModelDelegate {
    func emailExists() {
        let optionsVC = ForgotSheetViewController()
        optionsVC.email = emailTextField.text
        if let sheet = optionsVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        optionsVC.modalPresentationStyle = .pageSheet
        present(optionsVC, animated: true)
    }
    
    func emailDoesNotExists() {
        let alert = UIAlertController(title: "Error", message: "This email is not registered.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func didFailWithError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func passwordResetSent() {}
}
