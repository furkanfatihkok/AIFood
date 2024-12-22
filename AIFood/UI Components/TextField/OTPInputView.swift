//
//  OTPInputView.swift
//  AIFood
//
//  Created by FFK on 16.12.2024.
//

import UIKit

protocol OTPInputViewProtocol: AnyObject {
    func didEnterCode(_ code: String)
}

final class OTPInputView: UIView {
    
    // MARK: - Properties
    weak var delegate: OTPInputViewProtocol?
    private let numberOfFields: Int
    private var textFields: [UITextField] = []
    
    // MARK: - UI Components
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var createTextFields: [UITextField] = {
        var fields: [UITextField] = []
        for index in 0..<numberOfFields {
            let textField = UITextField()
            textField.tag = index
            textField.delegate = self
            textField.textAlignment = .center
            textField.font = Constants.Fonts.interRegular(size: 32)
            textField.keyboardType = .numberPad
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.systemGray6.cgColor
            textField.layer.cornerRadius = 12
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            fields.append(textField)
        }
        return fields
    }()
    
    // MARK: - Initializer
    init(numberOfFields: Int = 4) {
        self.numberOfFields = numberOfFields
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        addSubview(stackView)
        
        // TextFields oluşturulup stackView'a eklenir
        createTextFields.forEach { textField in
            textFields.append(textField)
            stackView.addArrangedSubview(textField)
        }
        
        // İlk kutucuğa odaklan
        textFields.first?.becomeFirstResponder()
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(72)
        }
        
        textFields.forEach { textField in
            textField.snp.makeConstraints { make in
                make.height.equalTo(72)
                make.width.equalTo(74)
            }
        }
    }
    
    // MARK: - Public Methods
    func resetFields() {
        textFields.forEach { $0.text = "" }
        textFields.first?.becomeFirstResponder()
    }
    
    func getCode() -> String {
        return textFields.compactMap { $0.text }.joined()
    }
}

// MARK: - TextField Logic
extension OTPInputView: UITextFieldDelegate {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let currentIndex = textField.tag
        let text = textField.text ?? ""
        
        if text.count > 1 {
            textField.text = String(text.prefix(1))
        }
        
        if currentIndex == numberOfFields - 1 && text.count == 1 {
            let otpCode = textFields.compactMap { $0.text }.joined()
            delegate?.didEnterCode(otpCode)
        }
        
        if text.count == 1 {
            let nextIndex = currentIndex + 1
            if nextIndex < numberOfFields {
                textFields[nextIndex].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        if text.count == 0 {
            let previousIndex = currentIndex - 1
            if previousIndex >= 0 {
                textFields[previousIndex].becomeFirstResponder()
            }
        }
    }
}
