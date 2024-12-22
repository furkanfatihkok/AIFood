//
//  AuthViewModel.swift
//  AIFood
//
//  Created by FFK on 17.12.2024.
//

import Foundation
import FirebaseAuth

protocol RegisterViewModelDelegate: AnyObject {
    func didRegisterSuccses()
    func didRegisterFail(with error: String)
}

protocol RegisterViewModelProtocol {
    var delegate: RegisterViewModelDelegate? { get set }
    func registerUser(email: String, password: String)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    weak var delegate: RegisterViewModelDelegate?
    private let authManager: FirebaseAuthManagerProtocol
    
    init(authManager: FirebaseAuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func registerUser(email: String, password: String) {
        authManager.registerUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didRegisterSuccses()
            case .failure(let error):
                self?.delegate?.didRegisterFail(with: error.localizedDescription)
            }
        }
    }
}
