//
//  AuthTextField.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

final class AuthTextField: UITextField {
    
    private var isPasswordVisible: Bool = false
    
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        setupTextFieldAppearance(placeholder: placeholder, isSecure: isSecure)
        
        if isSecure {
            setupEyeButton()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextFieldAppearance(placeholder: String, isSecure: Bool = false) {
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        self.borderStyle = .roundedRect
        self.font = Constants.Fonts.interRegular(size: 16)
        self.autocapitalizationType = .none
        self.keyboardType = isSecure ? .default : .emailAddress
    }
    
    private func setupEyeButton() {
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        eyeButton.tintColor = .black
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        eyeButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        self.rightView = eyeButton
        self.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        self.isSecureTextEntry = !isPasswordVisible

        if let eyeButton = self.rightView as? UIButton {
            eyeButton.isSelected = isPasswordVisible
        }
    }
}

