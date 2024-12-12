//
//  OnboardingButton.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

final class OnboardingButton: UIButton {
    // MARK: - Initializer
    init(title: String, action: Selector, target: AnyObject) {
        super.init(frame: .zero)
        setupButton(title: title, action: action, target: target)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton(title: String, action: Selector, target: AnyObject) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 8
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}

