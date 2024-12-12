//
//  OnboardingCell.swift
//  AIFood
//
//  Created by FFK on 11.12.2024.
//

import UIKit
import SnapKit

protocol OnboardingCellProtocol: AnyObject {
    func didTapSkipButton()
    func didTapOkButton()
    func didTapNextButton(at index: Int)
}

final class OnboardingCell: UICollectionViewCell {
    static let identifier = "OnboardingCell"
    
    weak var delegate: OnboardingCellProtocol?
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Constants.Colors.primaryColor
        containerView.layer.cornerRadius = 48
        return containerView
    }()
    
    private let onboardingTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        #warning("Fontları ekle")
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let onboardingDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var skipButton: UIButton = {
        OnboardingButton.onboardingButton(title: "Skip", titleColor: .white, target: self, action: #selector(skipTapped))
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("→", for: .normal)
        button.setTitleColor(Constants.Colors.primaryColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = .white
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.isHidden = true
        button.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        OnboardingButton.onboardingButton(title: "Next →", titleColor: .white, target: self, action: #selector(nextTapped))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(onboardingImage)
        contentView.addSubview(containerView)
        containerView.addSubview(onboardingTitle)
        containerView.addSubview(onboardingDescription)
        containerView.addSubview(skipButton)
        containerView.addSubview(okButton)
        containerView.addSubview(nextButton)
        
        // onboardingImage tüm ekranı kaplayacak
        onboardingImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // containerView onboardingImage'in üstüne gelecek
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.4) // Ekranın %40’ını kapsayacak
        }
        
        onboardingTitle.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        onboardingDescription.snp.makeConstraints { make in
            make.top.equalTo(onboardingTitle.snp.bottom).offset(12)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        skipButton.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
        }
        
        okButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
            make.width.height.equalTo(80)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).inset(16)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
        }
    }

    // MARK: - Button Actions
    @objc private func skipTapped() {
        delegate?.didTapSkipButton()
    }
    
    @objc private func okTapped() {
        delegate?.didTapOkButton()
    }
    
    @objc private func nextTapped() {
        delegate?.didTapNextButton(at: tag)
    }
    
    // MARK: - Configure
    func configure(with slide: OnboardingSlide, at index: Int, totalSlides: Int) {
        onboardingImage.image = UIImage(named: slide.imageName)
        onboardingTitle.text = slide.title
        onboardingDescription.text = slide.description
        tag = index

        let isLastPage = index == totalSlides - 1
        skipButton.isHidden = isLastPage
        nextButton.isHidden = isLastPage
        okButton.isHidden = !isLastPage
    }

}
