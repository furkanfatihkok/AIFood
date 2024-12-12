//
//  AuthTextField.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

final class AuthTextField: UITextField {
    
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        self.borderStyle = .roundedRect
        self.font = Constants.Fonts.interRegular(size: 16)
        self.autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
