//
//  OnboardingLabel.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

final class OnboardingLabel: UILabel {
    // MARK: - Initializer
    init(text: String? = nil, font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .center, numberOfLines: Int = 0) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

