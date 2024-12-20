//
//  ForgotPasswordViewModel.swift
//  AIFood
//
//  Created by FFK on 20.12.2024.
//

import Foundation

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func emailExists()
    func emailDoesNotExists()
    func didFailWithError(_ error: String)
}

protocol ForgotPasswordViewModelProtocol {
    var delegate: ForgotPasswordViewModelDelegate { get set }
    func checkIfEmailExists(email: String)
}

final class ForgotPasswordViewModel {
    weak var delegate: ForgotPasswordViewModelDelegate?
    private let authManager: FirebaseAuthManagerProtocol
    
    init(delegate: ForgotPasswordViewModelDelegate?, authManager: FirebaseAuthManagerProtocol) {
        self.delegate = delegate
        self.authManager = authManager
    }
    
    func checkIfEmailExists(email: String) {
        authManager.checkIfEmailExistsInFirestore(email: email) { [weak self] result in
            switch result {
            case .success(let exists):
                if exists {
                    self?.delegate?.emailExists()
                } else {
                    self?.delegate?.emailDoesNotExists()
                }
            case .failure(let error):
                self?.delegate?.didFailWithError(error.localizedDescription)
            }
        }
    }
}
