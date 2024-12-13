//
//  TitleLabel.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

final class TitleLabel: UILabel {
    
    enum LabelStyle {
        case title
        case subtitle
        case email
        case password
        case footer
    }
    
    init(text: String, style: LabelStyle) {
        super.init(frame: .zero)
        setupLabelAppearance(text: text)
        
        switch style {
        case .title:
            self.font = Constants.Fonts.interSemiBold(size: 32)
            self.textColor = .black
        case .subtitle:
            self.font = Constants.Fonts.interMedium(size: 14)
            self.textColor = .darkGray
        case .email:
            self.font = Constants.Fonts.interMedium(size: 14)
            self.textColor = .black
        case .password:
            self.font = Constants.Fonts.interMedium(size: 14)
            self.textColor = .black
        case .footer:
            self.font = Constants.Fonts.interMedium(size: 14)
            self.textColor = .black
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabelAppearance(text: String) {
        self.text = text
        self.textAlignment = .left
        self.numberOfLines = 0
    }
}
