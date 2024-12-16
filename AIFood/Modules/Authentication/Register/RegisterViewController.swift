//
//  RegisterViewController.swift
//  AIFood
//
//  Created by FFK on 13.12.2024.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var titleLabel: TitleLabel = {
        return TitleLabel(text: "Create your new \naccount", style: .title)
    }()
    
    private lazy var subTitleLabel: TitleLabel = {
        return TitleLabel(text: "Create an account to start looking for the food \nyou like", style: .subtitle)
    }()
    
    private lazy var emailLabel: TitleLabel = {
        return TitleLabel(text: "Email Address", style: .email)
    }()
    
    private lazy var emailTextField: AuthTextField = {
        return AuthTextField(placeholder: "Enter email")
    }()
    
    private lazy var usernameLabel: TitleLabel = {
        return TitleLabel(text: "User Name", style: .email)
    }()
    
    private lazy var usernameTextField: AuthTextField = {
        return AuthTextField(placeholder: "Enter usarname")
    }()
    
    private lazy var passwordLabel: TitleLabel = {
        return TitleLabel(text: "Password", style: .password)
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        return AuthTextField(placeholder: "Password", isSecure: true)
    }()
    
    private lazy var policyView: CustomPolicyView = {
        let view = CustomPolicyView()
        return view
    }()
    
    private lazy var registerButton: ActionButton = {
        let button =  ActionButton(title: "Register", type: .primary)
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
    
    private lazy var signInButton: ActionButton = {
        let button = ActionButton(title: "Sign In", type: .register)
        button.delegate = self
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTapped()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(policyView)
        view.addSubview(registerButton)
        view.addSubview(orSignInWithLabel)
        view.addSubview(socialButtonStackView)
        view.addSubview(footerLabel)
        view.addSubview(signInButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing / 1.5)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(verticalSpacing * 1.25)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(verticalSpacing * 1.25)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(verticalSpacing * 1.25)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        policyView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(verticalSpacing)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin / 2)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(policyView.snp.bottom).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin)
            make.height.equalTo(52)
        }
        
        orSignInWithLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(verticalSpacing)
            make.centerX.equalToSuperview()
        }
        
        socialButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(orSignInWithLabel.snp.bottom).offset(verticalSpacing)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.top.equalTo(socialButtonStackView.snp.bottom).offset(verticalSpacing * 2)
            make.centerX.equalToSuperview().offset(-40)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerY.equalTo(footerLabel)
            make.leading.equalTo(footerLabel.snp.trailing).offset(2)
        }
    }
}

extension RegisterViewController: ActionButtonProtocol {
    func didTapPrimaryButton() {
        if !policyView.checkBoxButton.isSelected {
            let alert = UIAlertController(title: "Error", message: "Please agree to the Privacy Policy before proceeding.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        print("Registration completed!")
    }
    
    func didTapForgotPasswordButton() {
        // TODO: Policy format
    }
    
    func didTapRegisterButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: SocialMediaButtonProtocol {
    func didTapGoogleButton() {
        print("Google")
    }
    
    func didTapFacebookButton() {
        print("Facebook")
    }
    
    func didTapAppleButton() {
        print("Apple")
    }
}
