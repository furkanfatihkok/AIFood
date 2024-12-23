//
//  ChangePasswordViewController.swift
//  AIFood
//
//  Created by FFK on 17.12.2024.
//

import UIKit

final class ChangePasswordViewController: UIViewController {
    
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
        return TitleLabel(text: "Reset Password", style: .title)
    }()
    
    private lazy var subtitle: TitleLabel = {
        return TitleLabel(text: "Your new password must be different from the previously used password", style: .subtitle)
    }()
    
    private lazy var newPasswordLabel: TitleLabel = {
        return TitleLabel(text: "New Password", style: .email)
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        return AuthTextField(placeholder: "New Password", isSecure: true)
    }()
    
    // TODO: Must be at least 8 character
    
    private lazy var confirmPasswordLabel: TitleLabel = {
        return TitleLabel(text: "Confirm Password", style: .email)
    }()
    
    private lazy var confirmTextField: AuthTextField = {
        return AuthTextField(placeholder: "Confirm password", isSecure: true)
    }()
    
    // TODO: Both password must match
    
    private lazy var verifyAccountButton: ActionButton = {
        let button = ActionButton(
            title: "Verify Account",
            type: .primary)
        button.delegate = self
        return button
    }()
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        hideKeyboardWhenTapped()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(titleLabel)
        view.addSubview(subtitle)
        view.addSubview(newPasswordLabel)
        view.addSubview(passwordTextField)
        // TODO: Must be at least 8 character
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmTextField)
        // TODO: Both password must match
        view.addSubview(verifyAccountButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(verticalSpacing * 3)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing / 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        newPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(verticalSpacing * 1.5)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
        
        // TODO: Must be at least 8 character
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().offset(horizontalMargin)
        }
        
        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(verticalSpacing / 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
        
        // TODO: Both password must match
        
        verifyAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(verticalSpacing * 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
    }
}

// MARK: NavigationBarProtocol
extension ChangePasswordViewController: NavigationBarProtocol {
    func didTapLeftButton() {
        print("left button tapped")
    }
    
    func didTapRightButton() {}
}

// MARK: - ActionButtonProtocol
extension ChangePasswordViewController: ActionButtonProtocol {
    func didTapButton(ofType type: ActionButton.ButtonType) {
        switch type {
        case .primary:
            let successVC = SuccessPasswordViewController()
            
            if let sheet = successVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            successVC.modalPresentationStyle = .pageSheet
            present(successVC, animated: true)
        default:
            break
        }
    }
}
