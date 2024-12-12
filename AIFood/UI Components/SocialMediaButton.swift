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
        setupButtonAppearance()
        
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
    
    private func setupButtonAppearance() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1 // Border genişliği
        self.layer.borderColor = UIColor.lightGray.cgColor // Gri renk
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }
}
