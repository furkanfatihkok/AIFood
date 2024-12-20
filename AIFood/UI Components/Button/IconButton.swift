//
//  IconButton.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit

// TODO: GENERİC hale getir burayı çünkü her vc de aynı buttonlar kullanılmıyor.

protocol IconButtonProtocol: AnyObject {
    func didTapIconButton(_ button: IconButton<AnyObject>)
}

protocol SocialMediaButtonProtocol: AnyObject {
    func didTapGoogleButton()
    func didTapFacebookButton()
    func didTapAppleButton()
}

final class IconButton<T: AnyObject>: UIButton {
    
    enum IconType {
        case google
        case facebook
        case apple
        case custom(UIImage)
    }
    
    // MARK: - Properties
    weak var delegate: T?
    private let iconType: IconType
    
    // MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    // MARK: - Initializer
    init(iconType: IconType, size: CGSize, borderColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, backgroundColor: UIColor) {
        self.iconType = iconType
        super.init(frame: .zero)
        
        setupButton(size: size, borderColor: borderColor, cornerRadius: cornerRadius, borderWidth: borderWidth, backgroundColor: backgroundColor)
        setIcon(for: iconType)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton(size: CGSize, borderColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(size.width * 0.5)
        }
        
        self.snp.makeConstraints { make in
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setIcon(for type: IconType) {
        switch type {
        case .google:
            iconImageView.image = UIImage(named: "google-icon")
        case .facebook:
            iconImageView.image = UIImage(named: "facebook-icon")
        case .apple:
            iconImageView.image = UIImage(systemName: "apple.logo")
        case .custom(let image):
            iconImageView.image = image
        }
    }
    
    // MARK: - Button Action
    @objc private func buttonTapped() {
        if let delegate = delegate as? SocialMediaButtonProtocol {
            switch iconType {
            case .google: delegate.didTapGoogleButton()
            case .facebook: delegate.didTapFacebookButton()
            case .apple: delegate.didTapAppleButton()
            default: break
            }
        }
        
        if let delegate = delegate as? IconButtonProtocol,
           let button = self as? IconButton<AnyObject> {
            delegate.didTapIconButton(button)
        }
    }
}
