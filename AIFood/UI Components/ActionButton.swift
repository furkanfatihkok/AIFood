//
//  CustomButton.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

protocol ActionButtonProtocol: AnyObject {
    func didTapPrimaryButton()
    func didTapForgotPasswordButton()
    func didTapRegisterButton()
}

final class ActionButton: UIButton {
    
    enum ButtonType {
        case primary
        case forgotPassword
        case register
    }
    
    weak var delegate: ActionButtonProtocol?
    private let type: ButtonType
    
    init(title: String, type: ButtonType) {
        self.type = type
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        
        switch type {
        case .primary:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = Constants.Colors.primaryColor
            self.titleLabel?.font = Constants.Fonts.interSemiBold(size: 14)
            self.layer.cornerRadius = 8
        case .forgotPassword:
            self.setTitleColor(Constants.Colors.primaryColor, for: .normal)
            self.backgroundColor = .clear
            self.titleLabel?.font = Constants.Fonts.interSemiBold(size: 14)
        case .register:
            self.setTitleColor(Constants.Colors.primaryColor, for: .normal)
            self.backgroundColor = .clear
            self.titleLabel?.font = Constants.Fonts.interSemiBold(size: 14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        switch type {
        case .primary:
            delegate?.didTapPrimaryButton()
        case .forgotPassword:
            delegate?.didTapForgotPasswordButton()
        case .register:
            delegate?.didTapRegisterButton()
        }
    }
}
