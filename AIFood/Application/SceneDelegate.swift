//
//  SceneDelegate.swift
//  AIFood
//
//  Created by FFK on 10.12.2024.
//

import UIKit
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let onboardingCompletedKey = "isOnboardingCompleted"
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: onboardingCompletedKey)
        let rootViewController: UIViewController
        
        if isOnboardingCompleted  {
            let authManager = FirebaseAuthManager.shared
            let loginViewModel = LoginViewModel(authManager: authManager)
            rootViewController = LoginViewController(loginViewModel: loginViewModel)
        } else {
            rootViewController = OnboardingViewController()
        }
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        GIDSignIn.sharedInstance.handle(url)
    }
}
