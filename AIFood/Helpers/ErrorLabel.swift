//
//  ErrorLabel.swift
//  AIFood
//
//  Created by FFK on 23.12.2024.
//

import UIKit

import SnapKit

final class ErrorLabel {
    static func updateErrorLabel(_ label: UILabel, withMessage message: String?, heightConstraint: Constraint?) {
        if let message = message {
            label.text = message
            label.isHidden = false
            heightConstraint?.update(offset: 20)
        } else {
            label.text = ""
            label.isHidden = true
            heightConstraint?.update(offset: 0)
        }
        
        UIView.animate(withDuration: 0.3) {
            label.superview?.layoutIfNeeded()
        }
    }
}
