//
//  ForgotSheetOptionView.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit
import SnapKit

protocol ForgotSheetOptionViewProtocol: AnyObject {
    func didTapOption(_ optionView: ForgotSheetOptionView)
}

final class ForgotSheetOptionView: UIView {
    
    // MARK: - Properties
    private var isSelectedOption: Bool = false {
        didSet {
            updateSelectionState()
        }
    }
    weak var delegate: ForgotSheetOptionViewProtocol?
    
    // MARK: - UI Components
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.Colors.primaryColor
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.interSemiBold(size: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.interMedium(size: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.Colors.primaryColor
        imageView.isHidden = !isSelectedOption
        return imageView
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, labelsStack, checkmarkImageView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        return stack
    }()
    
    // MARK: - Initializer
    init(icon: UIImage, title: String, detail: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        self.isSelectedOption = isSelected
        iconImageView.image = icon
        titleLabel.text = title
        detailLabel.text = detail
        setupView()
        updateSelectionState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.backgroundColor = .systemGray6
        self.layer.borderColor = Constants.Colors.primaryColor.cgColor
        
        self.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        // Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSelection))
        self.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Update Selection State
    private func updateSelectionState() {
        self.layer.borderColor = isSelectedOption ? Constants.Colors.primaryColor.cgColor : UIColor.lightGray.cgColor
        checkmarkImageView.isHidden = !isSelectedOption
    }
    
    @objc private func toggleSelection() {
        delegate?.didTapOption(self)
    }
    
    // MARK: - Public Method
    func setSelected(_ isSelected: Bool) {
        self.isSelectedOption = isSelected
    }
}
