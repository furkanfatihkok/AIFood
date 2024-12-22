//
//  ForgotSheetViewController.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit
import SnapKit

final class ForgotSheetViewController: UIViewController {
    
    // MARK: - Properties
    private let forgotPasswordViewModel: ForgotPasswordViewModel
    private var options: [ForgotSheetOptionView] = []
    var email: String? {
        didSet {
            emailOption.detailLabel.text = email ?? "Email not found"
        }
    }
    
    init(forgotPasswordViewModel: ForgotPasswordViewModel) {
        self.forgotPasswordViewModel = forgotPasswordViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private lazy var titleLabel: TitleLabel = {
        return TitleLabel(text: "Forgot password?", style: .title)
    }()
    
    private lazy var descriptionLabel: TitleLabel = {
        return TitleLabel(text: "Select which contact details should we use to reset your password", style: .subtitle)
    }()
    
    private lazy var phoneOption: ForgotSheetOptionView = {
        let option = ForgotSheetOptionView(
            icon: UIImage(systemName: "message.circle.fill")!,
            title: "Send via phone",
            detail: "0 (544)  440 3328",
            isSelected: false
        )
        option.delegate = self
        return option
    }()
    
    private lazy var emailOption: ForgotSheetOptionView = {
        let option = ForgotSheetOptionView(
            icon: UIImage(systemName: "envelope.fill")!,
            title: "Send via email",
            detail: "",
            isSelected: true
        )
        option.delegate = self
        return option
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        options = [phoneOption, emailOption]
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(phoneOption)
        view.addSubview(emailOption)
        view.addSubview(continueButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(verticalSpacing * 2)
            make.leading.equalToSuperview().inset(horizontalMargin)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing / 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
        
        phoneOption.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing * 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(70)
        }
        
        emailOption.snp.makeConstraints { make in
            make.top.equalTo(phoneOption.snp.bottom).offset(verticalSpacing / 2)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(70)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(verticalSpacing * 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
    }
}

// MARK: - ForgotSheetOptionViewDelegate
extension ForgotSheetViewController: ForgotSheetOptionViewProtocol {
    func didTapOption(_ optionView: ForgotSheetOptionView) {
        for option in options {
            if option == optionView {
                option.setSelected(true)
            } else {
                option.setSelected(false)
            }
        }
    }
}

// MARK: - ActionButtonProtocol
extension ForgotSheetViewController: ActionButtonProtocol {
    func didTapPrimaryButton() {
        guard let email = emailOption.detailLabel.text, !email.isEmpty else { return }
        
        let otpVC = OTPViewController(email: email, forgotPasswordViewModel: forgotPasswordViewModel)
        otpVC.modalPresentationStyle = .fullScreen
        present(otpVC, animated: false)
    }
    
    func didTapForgotPasswordButton() {}
    
    func didTapRegisterButton() {}
}
