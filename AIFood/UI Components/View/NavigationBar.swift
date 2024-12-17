//
//  NavigationBar.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit
import SnapKit

protocol NavigationBarProtocol: AnyObject {
    func didTapLeftButton()
    func didTapRightButton()
}

final class NavigationBar: UIView {
    
    // MARK: - UI Components
    private lazy var leftButton: IconButton = {
        let button = IconButton<AnyObject>(
            iconType: .custom(UIImage(systemName: "chevron.left") ?? UIImage()),
            size: CGSize(width: 40, height: 40),
            borderColor: .systemGray5,
            cornerRadius: 20,
            borderWidth: 1,
            backgroundColor: .clear
        )
        button.delegate = self
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // MARK: - Properties
    weak var delegate: NavigationBarProtocol?
    private let leftButtonIcon: UIImage?
    private let titleText: String
    
    // MARK: - Initializer
    init(title: String, leftButtonIcon: UIImage?) {
        
        self.titleText = title
        self.leftButtonIcon = leftButtonIcon
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = .white
        addSubview(leftButton)
        addSubview(titleLabel)
        
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - IconButtonProtocol
extension NavigationBar: IconButtonProtocol {
    func didTapIconButton(_ button: IconButton<AnyObject>) {
        if button == leftButton {
            delegate?.didTapLeftButton()
        }
    }
}
