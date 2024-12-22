//
//  LoginViewModel.swift
//  AIFood
//
//  Created by FFK on 19.12.2024.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
    func didLoginSuccses()
    func didRegisterFail(with error: String)
}

protocol LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate? { get set }
    func loginUser(email: String, password: String)
    func loginWithGoogle(presenting viewController: UIViewController)
    func loginWithFacebook(presenting viewController: UIViewController)
}

final class LoginViewModel: LoginViewModelProtocol {
    weak var delegate: LoginViewModelDelegate?
    private let authManager: FirebaseAuthManagerProtocol
    
    init(authManager: FirebaseAuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func loginUser(email: String, password: String) {
        authManager.loginUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didLoginSuccses()
            case .failure(let error):
                self?.delegate?.didRegisterFail(with: error.localizedDescription)
            }
        }
    }
    
    func loginWithGoogle(presenting viewController: UIViewController) {
        authManager.signInWithGoogle(presenting: viewController) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didLoginSuccses()
            case .failure(let error):
                self?.delegate?.didRegisterFail(with: error.localizedDescription)
            }
        }
    }
    
    func loginWithFacebook(presenting viewController: UIViewController) {
        authManager.signInWithFacebook(presenting: viewController) { [weak self] result in
            switch result {
            case.success:
                self?.delegate?.didLoginSuccses()
            case .failure(let error):
                self?.delegate?.didRegisterFail(with: error.localizedDescription)
            }
        }
    }
}
