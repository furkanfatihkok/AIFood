//
//  CustomButton.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

protocol ActionButtonProtocol: AnyObject {
    func didTapButton(ofType type: ActionButton.ButtonType)
}

final class ActionButton: UIButton {
    
    enum ButtonType {
        case primary
        case secondary
        case tertiary
    }
    
    weak var delegate: ActionButtonProtocol?
    private let type: ButtonType
    
    // MARK: - Initializer
    init(title: String, type: ButtonType) {
        self.type = type
        super.init(frame: .zero)
        setupButtonAppearance(title: title)
        
        switch type {
        case .primary:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = Constants.Colors.primaryColor
            self.layer.cornerRadius = 24
        case .secondary, .tertiary:
            self.setTitleColor(Constants.Colors.primaryColor, for: .normal)
            self.backgroundColor = .clear
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButtonAppearance(title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = Constants.Fonts.interSemiBold(size: 14)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapButton(ofType: type)
    }
}
