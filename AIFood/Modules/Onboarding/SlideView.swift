//
//  SlideView.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit
import SnapKit

protocol SlideViewProtocol: AnyObject {
    func didChangePage(to index: Int)
    func didTapSkipButton()
    func didTapNextButton(at index: Int)
    func didTapOkButton()
}

final class SlideView: UIView {
    
    weak var delegate: SlideViewProtocol?
    private var currentPage = 0
    private var totalPages = 0
    
    // MARK: - UI Elements
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.primaryColor
        view.layer.cornerRadius = 48
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.interSemiBold(size: 32) ?? UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.interRegular(size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray5
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = totalPages
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        return pageControl
    }()
    
    private lazy var nextButton: UIButton = OnboardingButton(
        title: "Next →",
        action: #selector(nextTapped),
        target: self
    )
    
    private lazy var skipButton: UIButton = OnboardingButton(
        title: "Skip",
        action: #selector(skipTapped),
        target: self
    )
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("→", for: .normal)
        button.setTitleColor(Constants.Colors.primaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 40
        button.isHidden = true
        button.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(imageView)
        addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(pageControl)
        containerView.addSubview(nextButton)
        containerView.addSubview(skipButton)
        containerView.addSubview(okButton)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.84)
            make.height.equalToSuperview().multipliedBy(0.46)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).inset(32)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
        }
        
        skipButton.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).inset(32)
            make.bottom.equalTo(containerView.snp.bottom).inset(16)
        }
        
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(containerView.snp.bottom).inset(32)
            make.width.height.equalTo(80)
        }
    }
    
    // MARK: - Actions
    @objc private func nextTapped() {
        delegate?.didTapNextButton(at: currentPage)
    }
    
    @objc private func skipTapped() {
        delegate?.didTapSkipButton()
    }
    
    @objc private func okTapped() {
        delegate?.didTapOkButton()
    }
    
    @objc private func pageControlChanged() {
        delegate?.didChangePage(to: pageControl.currentPage)
    }
    
    // MARK: - Configure
    func configure(with slide: OnboardingSlide, currentPage: Int, totalPages: Int, isLastSlide: Bool) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = currentPage
        
        imageView.image = UIImage(named: slide.imageName)
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
        
        skipButton.isHidden = isLastSlide
        nextButton.isHidden = isLastSlide
        okButton.isHidden = !isLastSlide
    }
}
