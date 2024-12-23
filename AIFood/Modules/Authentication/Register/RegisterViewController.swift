//
//  RegisterViewController.swift
//  AIFood
//
//  Created by FFK on 13.12.2024.
//

import UIKit
import SnapKit

final class RegisterViewController: BaseViewController {
    
    // MARK: - Properties
    private let registerViewModel: RegisterViewModel?
    private let loginViewModel: LoginViewModel?
    
    init(registerViewModel: RegisterViewModel? = nil, loginViewModel: LoginViewModel? = nil) {
        self.registerViewModel = registerViewModel
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
        registerViewModel?.delegate = self
        loginViewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private lazy var emailErrorLabel: TitleLabel = {
        let label =  TitleLabel(text: "", style: .password)
        label.isHidden = true
        return label
    }()
    
    private var emailErrorLabelHeightConstraint: Constraint?
    
    private lazy var usernameLabel: TitleLabel = {
        return TitleLabel(text: "User Name", style: .email)
    }()
    
    private lazy var usernameTextField: AuthTextField = {
        return AuthTextField(placeholder: "Enter usarname")
    }()
    
    private lazy var usernameErrorLabel: TitleLabel = {
        let label = TitleLabel(text: "", style: .password)
        label.isHidden = true
        return label
    }()
    
    private var usernameErrorLabelHeightConstraint: Constraint?
    
    private lazy var passwordLabel: TitleLabel = {
        return TitleLabel(text: "Password", style: .email)
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        return AuthTextField(placeholder: "Password", isSecure: true)
    }()
    
    private lazy var passwordErrorLabel: TitleLabel = {
        let label = TitleLabel(text: "", style: .password)
        label.isHidden = true
        return label
    }()
    
    private var passwordErrorLabelHeightConstraint: Constraint?
    
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
        let iconButtonSize = CGSize(width: 40, height: 40)
        
        let googleButton = IconButton<AnyObject>(
            iconType: .google,
            size: iconButtonSize,
            borderColor: .systemGray5,
            cornerRadius: 20,
            borderWidth: 0.5,
            backgroundColor: .clear
        )
        googleButton.delegate  = self
        
        let facebookButton = IconButton<AnyObject>(
            iconType: .facebook,
            size: iconButtonSize,
            borderColor: .systemGray5,
            cornerRadius: 20,
            borderWidth: 0.5,
            backgroundColor: .clear
        )
        facebookButton.delegate  = self
        
        let appleButton = IconButton<AnyObject>(
            iconType: .apple,
            size: iconButtonSize,
            borderColor: .systemGray5,
            cornerRadius: 20,
            borderWidth: 0.5,
            backgroundColor: .clear
        )
        appleButton.delegate  = self
        
        let stackView = UIStackView(arrangedSubviews: [googleButton, facebookButton, appleButton])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var footerLabel: TitleLabel = {
        return TitleLabel(text: "Don't have an account?", style: .footer)
    }()
    
    private lazy var signInButton: ActionButton = {
        let button = ActionButton(title: "Sign In", type: .tertiary)
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
        view.addSubview(emailErrorLabel)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(usernameErrorLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordErrorLabel)
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
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
        
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            emailErrorLabelHeightConstraint = make.height.equalTo(0).constraint
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(emailErrorLabel.snp.bottom).offset(verticalSpacing * 1.25)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
        
        usernameErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            usernameErrorLabelHeightConstraint = make.height.equalTo(0).constraint
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameErrorLabel.snp.bottom).offset(verticalSpacing * 1.25)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
        
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            passwordErrorLabelHeightConstraint = make.height.equalTo(0).constraint
        }
        
        policyView.snp.makeConstraints { make in
            make.top.equalTo(passwordErrorLabel.snp.bottom).offset(verticalSpacing)
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().offset(-horizontalMargin / 2)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(policyView.snp.bottom).offset(verticalSpacing * 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
        
        orSignInWithLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(verticalSpacing)
            make.centerX.equalToSuperview()
        }
        
        socialButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(orSignInWithLabel.snp.bottom).offset(verticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(socialButtonStackView.snp.bottom).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin * 5)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerY.equalTo(footerLabel)
            make.leading.equalTo(footerLabel.snp.trailing).offset(2)
        }
    }
}

// MARK: - ActionButtonProtocol
extension RegisterViewController: ActionButtonProtocol {
    func didTapButton(ofType type: ActionButton.ButtonType) {
        switch type {
        case .primary:
            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let username = usernameTextField.text ?? ""
            var hasError = false
            
            if let emailError = Validator.validateEmail(email) {
                ErrorLabel.updateErrorLabel(emailErrorLabel, withMessage: emailError, heightConstraint: emailErrorLabelHeightConstraint)
                hasError = true
            } else {
                ErrorLabel.updateErrorLabel(emailErrorLabel, withMessage: nil, heightConstraint: emailErrorLabelHeightConstraint)
            }
            
            if let usernameError = Validator.validateUsername(username) {
                ErrorLabel.updateErrorLabel(usernameErrorLabel, withMessage: usernameError, heightConstraint: usernameErrorLabelHeightConstraint)
                hasError = true
            } else {
                ErrorLabel.updateErrorLabel(usernameErrorLabel, withMessage: nil, heightConstraint: usernameErrorLabelHeightConstraint)
            }
            
            if let passwordError = Validator.validatePassword(password) {
                ErrorLabel.updateErrorLabel(passwordErrorLabel, withMessage: passwordError, heightConstraint: passwordErrorLabelHeightConstraint)
                hasError = true
            } else {
                ErrorLabel.updateErrorLabel(passwordErrorLabel, withMessage: nil, heightConstraint: passwordErrorLabelHeightConstraint)
            }
            
            guard !hasError else { return }
            
            registerViewModel?.registerUser(email: email, password: password)
            
        case .secondary:
            // TODO: Policy format
            print("Policy format")
        case .tertiary:
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - SocialMediaButtonProtocol
extension RegisterViewController: SocialMediaButtonProtocol {
    func didTapGoogleButton() {
        loginViewModel?.loginWithGoogle(presenting: self)
    }
    
    func didTapFacebookButton() {
        loginViewModel?.loginWithFacebook(presenting: self)
    }
    
    func didTapAppleButton() {
        print("Apple")
    }
}

// MARK: - RegisterViewModelDelegate
extension RegisterViewController: RegisterViewModelDelegate {
    func didRegisterSuccses() {
        let authManager = FirebaseAuthManager.shared
        let loginViewModel = LoginViewModel(authManager: authManager)
        let loginVC = LoginViewController(loginViewModel: loginViewModel)
        
        navigationController?.setViewControllers([loginVC], animated: true)
    }
    
    func didRegisterFail(with error: String) {
        presentAlert(title: "Error", message: error)
    }
}

// MARK: - LoginViewModelDelegate
extension RegisterViewController: LoginViewModelDelegate {
    func didLoginSuccses() {
        let homeVC = HomeViewController()
        navigationController?.setViewControllers([homeVC], animated: true)
    }
    
    func didRegisterError(with error: String) {
        presentAlert(title: "Error", message: error)
    }
}
