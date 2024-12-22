//
//  MailjetServiceManager.swift
//  AIFood
//
//  Created by FFK on 20.12.2024.
//

import Foundation

final class MailjetServiceManager {
    static let shared = MailjetServiceManager()
    private init() {}
    
    func sendEmailWithVerificationCode(to recipientEmail: String, verificationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = URL(string: "https://api.mailjet.com/v3.1/send")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let apiKey = "d5ea96f5a9567c6e81043c93c5f60f2d"
        let apiSecret = "5d865e1fa288cfcb4a23fdeae7690598"
        
        let credentials = "\(apiKey):\(apiSecret)"
        let credentialsData = credentials.data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(credentialsData)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let emailBody: [String: Any] = [
            "Messages": [
                [
                    "From": [
                        "Email": "aifood2323@gmail.com",
                        "Name": "AIFood Sender"
                    ],
                    "To": [
                        ["Email": recipientEmail]
                    ],
                    "Subject": "Your Verification Code",
                    "TextPart": "Your verification code is: \(verificationCode)",
                    "HTMLPart": "<p>Your verification code is: <strong>\(verificationCode)</strong></p>"
                ]
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: emailBody, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Email sent successfully to \(recipientEmail)")
                completion(.success(()))
            } else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                print("Failed to send email, HTTP status code: \(statusCode)")
                let error = NSError(domain: "MailjetService", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to send email"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
