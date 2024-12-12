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
        self.text = text
        self.textAlignment = .center
        self.numberOfLines = 0
        
        switch style {
        case .title:
            self.font = Constants.Fonts.interSemiBold(size: 32)
            self.textColor = .black
        case .subtitle:
            self.font = Constants.Fonts.interMedium(size: 14)
            self.textColor = .darkGray
        case .email:
            self.font = Constants.Fonts.interMedium(size: 14)
        case .password:
            self.font = Constants.Fonts.interMedium(size: 14)
        case .footer:
            self.font = Constants.Fonts.interMedium(size: 14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
