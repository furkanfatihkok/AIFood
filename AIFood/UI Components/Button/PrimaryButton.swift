//
//  OnboardingButton.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

protocol PrimaryButtonProtocol: AnyObject {
    func didTapPrimaryButton(_ button: PrimaryButton)
}

final class PrimaryButton: UIButton {
    
    weak var delegate: PrimaryButtonProtocol?
    
    // MARK: - Initializer
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 8
        self.addTarget(target, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapPrimaryButton(self)
    }
}
