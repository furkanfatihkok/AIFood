//
//  OnboardingButton.swift
//  AIFood
//
//  Created by FFK on 11.12.2024.
//

import UIKit

struct OnboardingButton {
    
    static func onboardingButton(title: String, titleColor: UIColor = .white, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
