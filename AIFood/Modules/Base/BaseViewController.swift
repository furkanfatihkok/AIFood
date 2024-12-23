//
//  BaseViewController.swift
//  AIFood
//
//  Created by FFK on 23.12.2024.
//

import UIKit

class BaseViewController: UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
