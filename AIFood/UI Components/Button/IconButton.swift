//
//  IconButton.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit

protocol IconButtonProtocol: AnyObject {
    func didTapIconButton(_ button: IconButton)
}

final class IconButton: UIButton {
    
    // MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    // MARK: - Properties
    weak var delegate: IconButtonProtocol?
    
    // MARK: - Initializer
    init(icon: UIImage?, size: CGSize, borderColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, backgroundColor: UIColor) {
        super.init(frame: .zero)
        setupButton(icon: icon, size: size, borderColor: borderColor, cornerRadius: cornerRadius, borderWidth: borderWidth, backgroundColor: backgroundColor)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton(icon: UIImage?, size: CGSize, borderColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        iconImageView.image = icon
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(size.width * 0.5)
        }
        
        self.snp.makeConstraints { make in
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
    }
    
    // MARK: - Button Action
    @objc private func buttonTapped() {
        delegate?.didTapIconButton(self)
    }
}
