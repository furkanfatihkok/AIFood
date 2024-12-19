//
//  FirebaseAuthManager.swift
//  AIFood
//
//  Created by FFK on 17.12.2024.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthManagerProtocol: AnyObject {
    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
}

final class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    private init() {}
}

extension FirebaseAuthManager: FirebaseAuthManagerProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Result<FirebaseAuth.AuthDataResult, any Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<FirebaseAuth.AuthDataResult, any Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
}
