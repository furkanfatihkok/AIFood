//
//  Validator.swift
//  AIFood
//
//  Created by FFK on 23.12.2024.
//

import Foundation

final class Validator {
    static func validateEmail(_ email: String) -> String? {
        if email.isEmpty {
            return "Email field cannot be empty."
        } else if !email.isValidEmail() {
            return "Please enter a valid email address."
        }
        return nil
    }
    
    static func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Password field cannot be empty."
        } else if !password.isValidPassword() {
            return "Password does not meet requirements."
        }
        return nil
    }
    
    static func validateUsername(_ username: String) -> String? {
        if username.isEmpty {
            return "Username field cannot be empty."
        }
        return nil
    }
}
