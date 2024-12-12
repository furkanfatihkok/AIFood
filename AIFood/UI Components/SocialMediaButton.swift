//
//  SocialMediaButton.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit

protocol SocialMediaButtonProtocol: AnyObject {
    func didTapGoogleButton()
    func didTapFacebookButton()
    func didTapAppleButton()
}

final class SocialMediaButton: UIButton {
    
    enum SocialMediaType {
        case google
        case facebook
        case apple
    }
    
    weak var delegate: SocialMediaButtonProtocol?
    private let type: SocialMediaType
    
    init(type: SocialMediaType) {
        self.type = type
        super.init(frame: .zero)
        self.layer.cornerRadius = 8
        self.backgroundColor = .darkGray
        self.clipsToBounds = true
        
        switch type {
        case .google:
            self.setImage(UIImage(named: "google-icon"), for: .normal)
        case .facebook:
            self.setImage(UIImage(named: "facebook-icon"), for: .normal)
        case .apple:
            self.setImage(UIImage(named: "apple-icon"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        switch type {
        case .google:
            delegate?.didTapGoogleButton()
        case .facebook:
            delegate?.didTapFacebookButton()
        case .apple:
            delegate?.didTapAppleButton()
        }
    }
}
