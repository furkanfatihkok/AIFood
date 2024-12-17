//
//  SuccessfulPasswordView.swift
//  AIFood
//
//  Created by FFK on 17.12.2024.
//

import UIKit

final class SuccessfulPasswordView: UIView {
    
    // MARK: UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .successPassword)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var passwordChangedLabel: TitleLabel = {
        let label =  TitleLabel(text: "Password Changed", style: .title)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: TitleLabel = {
        let label =  TitleLabel(text: "Password changed successfully, you can login again with a new password", style: .subtitle)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(passwordChangedLabel)
        addSubview(descriptionLabel)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(verticalSpacing)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        passwordChangedLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordChangedLabel.snp.bottom).offset(verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
    }
}
