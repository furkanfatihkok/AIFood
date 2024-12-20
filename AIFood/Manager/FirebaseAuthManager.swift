//
//  FirebaseAuthManager.swift
//  AIFood
//
//  Created by FFK on 17.12.2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FacebookLogin

protocol FirebaseAuthManagerProtocol: AnyObject {
    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func saveEmailToFirestore(email: String)
    func checkIfEmailExistsInFirestore(email: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func signInWithFacebook(presenting viewController: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
}

// MARK: - FirebaseAuthManager
final class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    private init() {}
}

// MARK: - FirebaseAuthManagerProtocol
extension FirebaseAuthManager: FirebaseAuthManagerProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Result<FirebaseAuth.AuthDataResult, any Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                self?.saveEmailToFirestore(email: email)
                completion(.success(authResult))
            }
        }
    }
    
    func saveEmailToFirestore(email: String) {
        let db = Firestore.firestore()
        db.collection("emails").document(email).setData(["email": email]) { error in
            if let error = error {
                print("Error saving user: \(error.localizedDescription)")
            } else {
                print("User saved successfully to Firestore.")
            }
        }
    }
    
    func checkIfEmailExistsInFirestore(email: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        let db = Firestore.firestore()
        let emailDocument = db.collection("emails").document(email)
        
        emailDocument.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                completion(.success(true))
            } else {
                completion(.success(false))
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
    
    func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "FirebaseAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing client ID"])))
            return
        }
        //TODO: google ile giriş yapılan email firestore'a kaydet
        let signInConfig = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = signInConfig
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "FirebaseAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authentication failed"])))
                return
            }
            
            let idToken = user.idToken?.tokenString
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "no idToken", accessToken: accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    completion(.success(authResult))
                }
            }
        }
    }
    
    func signInWithFacebook(presenting viewController: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            //TODO: facebook ile giriş yapılan email firestore'a kaydet
            guard let result = result, !result.isCancelled else {
                completion(.failure(NSError(domain: "FirebaseAuthManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Facebook login canceled"])))
                return
            }
            
            guard let tokenString = AccessToken.current?.tokenString else {
                completion(.failure(NSError(domain: "FirebaseAuthManager", code: -3, userInfo: [NSLocalizedDescriptionKey: "Failed to get Facebook access token"])))
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    completion(.success(authResult))
                }
            }
        }
    }
}
