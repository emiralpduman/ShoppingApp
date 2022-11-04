//
//  AuthViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    // MARK: - Properties
    private var mainView = AuthView()
    private let viewModel = AuthViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign-In"
        view = mainView
        
        mainView.delegate = self
    }
}

// MARK: - Delegate Conformance
extension AuthViewController: AuthViewDelegate {
    func didButtonPressed(_ sender: UIButton) {
        switch mainView.signingMode {
        case .signIn:
            guard let email = mainView.emailTextField.text, let password = mainView.passwordTextField.text else {
                fatalError("No text content")
            }
            viewModel.signIn(email: email, password: password)
        case .signUp:
            guard let email = mainView.emailTextField.text, let userName = mainView.userNameTextField.text, let password1 = mainView.passwordTextField.text, let password2 = mainView.passwordRepeatTextField.text else {
                fatalError("No text content")
            }
            if password1 == password2 {
                viewModel.signUp(email: email, password: password1)
            }
            else {
                print("Passwords do not match")
            }
            
        }
    }
    
    func didValueChange(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        title = sender.titleForSegment(at: selectedIndex)
    }
}
