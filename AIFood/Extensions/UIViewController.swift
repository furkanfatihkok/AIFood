//
//  UIViewController.swift
//  AIFood
//
//  Created by FFK on 13.12.2024.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        if let hitView = view.hitTest(touchPoint, with: nil) {
            if let button = hitView as? UIButton, button.isDescendant(of: self.view) {
                return
            }
        }
        view.endEditing(true)
    }
}
