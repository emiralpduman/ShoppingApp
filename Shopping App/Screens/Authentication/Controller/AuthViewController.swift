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
    
    private var isThereServiceRequest: Bool = false {
        didSet {
            if isThereServiceRequest {
                view.backgroundColor = .white.withAlphaComponent(dimmingAlpha)
            } else {
                view.backgroundColor = .white
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign-In"
        view = mainView
        
        mainView.delegate = self
    }
    
    // MARK: - Drawing Constants
    private let dimmingAlpha: CGFloat = 0.5
}

// MARK: - View Delegate Conformance
extension AuthViewController: AuthViewDelegate {
    func didButtonPressed(_ sender: UIButton) {
        switch mainView.signingMode {
        case .signIn:
            guard let email = mainView.emailTextField.text, let password = mainView.passwordTextField.text else {
                fatalError("No text content")
            }
            viewModel.signIn(email: email, password: password)
            isThereServiceRequest = true
        case .signUp:
            guard let email = mainView.emailTextField.text, let userName = mainView.userNameTextField.text, let password1 = mainView.passwordTextField.text, let password2 = mainView.passwordRepeatTextField.text else {
                fatalError("No text content")
            }
            if password1 == password2 {
                viewModel.signUp(email: email, password: password1, userName: userName)
                isThereServiceRequest = true
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

// MARK: - ViewModel Delegate Conformance
extension AuthViewController: AuthViewModelDelegate {
    
}



