//
//  SuccessPasswordViewController.swift
//  AIFood
//
//  Created by FFK on 17.12.2024.
//

import UIKit

final class SuccessPasswordViewController: UIViewController {
    
    // MARK: UI Components
    private lazy var successView: SuccessfulPasswordView = {
        let view = SuccessfulPasswordView()
        return view
    }()
    
    private lazy var verifyAcoountButton: ActionButton = {
        let button = ActionButton(title: "Verify Account", type: .primary)
        button.delegate = self
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(successView)
        view.addSubview(verifyAcoountButton)
        
        let horizontalMargin = UIScreen.main.bounds.width * 0.05
        let verticalSpacing = UIScreen.main.bounds.height * 0.02
        
        successView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        verifyAcoountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(verticalSpacing * 1.5)
            make.leading.trailing.equalToSuperview().inset(horizontalMargin)
            make.height.equalTo(52)
        }
    }
}

// MARK: - ActionButtonProtocol
extension SuccessPasswordViewController: ActionButtonProtocol {
    func didTapButton(ofType type: ActionButton.ButtonType) {
        switch type {
        case .primary:
            print("vverify button to login VC")
        default:
            break
        }
    }
}
