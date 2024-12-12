//
//  LoginViewController.swift
//  AIFood
//
//  Created by FFK on 11.12.2024.
//

import UIKit
import SnapKit

#warning("keybord açılınca ekrana tıklanınca kapansın extension yaz.")

final class LoginViewController: UIViewController {
    
    //MARK: - UI Components
    private lazy var titleLabel: TitleLabel = {
        return TitleLabel(text: "Login to your \naccount.", style: .title)
    }()
    
    private lazy var subTitleLabel: TitleLabel = {
        return TitleLabel(text: "Please sign in to your account", style: .subtitle)
    }()
    
    private lazy var emailLabel: TitleLabel = {
        return TitleLabel(text: "Email Address", style: .email)
    }()
    
    private lazy var emailTextField: AuthTextField = {
        return AuthTextField(placeholder: "Enter email")
    }()
    
    private lazy var passwordLabel: TitleLabel = {
        return TitleLabel(text: "Password", style: .password)
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        return AuthTextField(placeholder: "Password", isSecure: true)
    }()
    
    private lazy var forgotPassword: ActionButton = {
        let button = ActionButton(title: "Forgot password?", type: .forgotPassword)
        button.delegate = self
        return button
    }()
    
    private lazy var signInButton: ActionButton = {
        let button =  ActionButton(title: "Sign In", type: .primary)
        button.delegate = self
        return button
    }()
    
    private lazy var orSignInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "--------- Or sign in with ----------"
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var socialButtonStackView: UIStackView = {
        let googleButton = SocialMediaButton(type: .google)
        googleButton.delegate  = self
        
        let facebookButton = SocialMediaButton(type: .facebook)
        facebookButton.delegate = self
        
        let appleButton = SocialMediaButton(type: .apple)
        appleButton.delegate = self
        
        let stackView = UIStackView(arrangedSubviews: [googleButton, facebookButton, appleButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var footerLabel: TitleLabel = {
        return TitleLabel(text: "Don't have an account?", style: .footer)
    }()
    
    private lazy var registerButton: ActionButton = {
        return ActionButton(title: "Register", type: .register)
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK:- Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPassword)
        view.addSubview(signInButton)
        view.addSubview(orSignInWithLabel)
        view.addSubview(socialButtonStackView)
        view.addSubview(footerLabel)
        view.addSubview(registerButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(verticalSpacing)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(verticalSpacing)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        forgotPassword.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(verticalSpacing)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPassword.snp.bottom).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        orSignInWithLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(verticalSpacing * 2)
            make.centerX.equalToSuperview()
        }
        
        socialButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(orSignInWithLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.top.equalTo(socialButtonStackView.snp.bottom).offset(verticalSpacing * 2)
            make.centerX.equalToSuperview().offset(-40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerY.equalTo(footerLabel)
            make.leading.equalTo(footerLabel.snp.trailing).offset(2)
        }
    }
}

// MARK: - SocialMediaButtonProtocol
extension LoginViewController: SocialMediaButtonProtocol {
    func didTapGoogleButton() {
        print("asdas")
    }
    
    func didTapFacebookButton() {
        print("asdas")
    }
    
    func didTapAppleButton() {
        print("asdas")
    }
}

// MARK: - ActionButtonProtocol
extension LoginViewController: ActionButtonProtocol {
    func didTapPrimaryButton() {
        print("asdas")
    }
    
    func didTapForgotPasswordButton() {
        print("asdas")
    }
    
    func didTapRegisterButton() {
        print("asdas")
    }
}
