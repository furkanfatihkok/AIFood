//
//  CustomPolicyView.swift
//  AIFood
//
//  Created by FFK on 13.12.2024.
//

import UIKit
import SnapKit

final class CustomPolicyView: UIView {
    
    // MARK: - UI Components
     lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    private lazy var policyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = createAttributedText()
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    private func setupView() {
        addSubview(checkBoxButton)
        addSubview(policyLabel)
        
        checkBoxButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        policyLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(checkBoxButton)
        }
    }
    
    private func createAttributedText() -> NSAttributedString {
        let text = "I Agree with Terms of Service and Privacy Policy"
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ], range: NSRange(location: 0, length: text.count))
        
        if let termsRange = text.range(of: "Terms of Service") {
            attributedString.addAttributes([
                .foregroundColor: UIColor.orange,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: NSRange(termsRange, in: text))
        }
        
        if let privacyRange = text.range(of: "Privacy Policy") {
            attributedString.addAttributes([
                .foregroundColor: UIColor.orange,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: NSRange(privacyRange, in: text))
        }
        
        return attributedString
    }
}
