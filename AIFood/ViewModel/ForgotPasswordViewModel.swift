//
//  ForgotPasswordViewModel.swift
//  AIFood
//
//  Created by FFK on 20.12.2024.
//

import Foundation

// MARK: - EmailValidationDelegate
protocol EmailValidationDelegate: AnyObject {
    func emailExists()
    func emailDoesNotExists()
    func didFailWithError(_ error: String)
}

// MARK: - VerificationCodeDelegate
protocol VerificationCodeDelegate: AnyObject {
    func verificationCodeSent()
    func verificationSuccessful()
    func verificationFailed(_ error: String)
}

// MARK: - ForgotPasswordViewModelProtocol
protocol ForgotPasswordViewModelProtocol {
    var emailDelegate: EmailValidationDelegate? { get set }
    var verificationCodeDelegate: VerificationCodeDelegate? { get set }
    func checkIfEmailExists(email: String)
    func requestVerificationCode(email: String)
    func verifyCode(inputCode: String)
}

// MARK: - ForgotPasswordViewModel
final class ForgotPasswordViewModel {
    weak var emailDelegate: EmailValidationDelegate?
    weak var verificationCodeDelegate: VerificationCodeDelegate?
    private let authManager: FirebaseAuthManagerProtocol
    private var generatedCode: String?
    
    init(authManager: FirebaseAuthManagerProtocol) {
        self.authManager = authManager
    }
    
    func checkIfEmailExists(email: String) {
        authManager.checkIfEmailExistsInFirestore(email: email) { [weak self] result in
            switch result {
            case .success(let exists):
                if exists {
                    self?.emailDelegate?.emailExists()
                } else {
                    self?.emailDelegate?.emailDoesNotExists()
                }
            case .failure(let error):
                self?.emailDelegate?.didFailWithError(error.localizedDescription)
            }
        }
    }
    
    func requestVerificationCode(email: String) {
        guard generatedCode == nil else {
            verificationCodeDelegate?.verificationFailed("A verification code has already been sent. Please check your email.")
            return
        }
        
        let code = String(format: "%04d", Int.random(in: 1000..<9999))
        self.generatedCode = code
        
        MailjetServiceManager.shared.sendEmailWithVerificationCode(to: email, verificationCode: code) { [weak self] result in
            switch result {
            case .success:
                print("Verification code sent successfully: \(code)")
                self?.verificationCodeDelegate?.verificationCodeSent()
            case .failure(let error):
                self?.generatedCode = nil
                self?.verificationCodeDelegate?.verificationFailed("Failed to send verification code: \(error.localizedDescription)")
            }
        }
    }
    
    func verifyCode(inputCode: String) {
        guard let actualCode = generatedCode else {
            verificationCodeDelegate?.verificationFailed("Verification code is not generated yet.")
            return
        }
        
        if inputCode == actualCode {
            verificationCodeDelegate?.verificationSuccessful()
        } else {
            verificationCodeDelegate?.verificationFailed("Incorrect verification code.")
        }
    }
}
