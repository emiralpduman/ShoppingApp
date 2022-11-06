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
                mainView.activityIndicator.startAnimating()
            } else {
                view.backgroundColor = .white
                mainView.activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign-In"
        view = mainView
        
        #if targetEnvironment(simulator)
        mainView.emailTextField.text = "emiralpduman@gmail.com"
        mainView.passwordTextField.text = "123456"
        #endif
        
        mainView.delegate = self
        viewModel.delegate = self
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
                let alert = UIAlertController(title: "Error", message: AuthViewControllerError.emptyInputFields.description, preferredStyle: .alert)
                alert.standardizeForAuth()
                self.present(alert, animated: true)
                return
            }
            viewModel.signIn(email: email, password: password)
        case .signUp:
            guard let email = mainView.emailTextField.text, let userName = mainView.userNameTextField.text, let password1 = mainView.passwordTextField.text, let password2 = mainView.passwordRepeatTextField.text else {
                let alert = UIAlertController(title: "Error", message: AuthViewControllerError.emptyInputFields.description, preferredStyle: .alert)
                alert.standardizeForAuth()
                self.present(alert, animated: true)
                return
            }
            if password1 == password2 {
                viewModel.signUp(email: email, password: password1, userName: userName)
            }
            else {
                let alert = UIAlertController(title: "Error", message: AuthViewControllerError.passwordsNoMatch.description, preferredStyle: .alert)
                alert.standardizeForAuth()
                self.present(alert, animated: true)
                return
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
    func didErrorOccur(error: Error) {
        isThereServiceRequest = false
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.standardizeForAuth()
        self.present(alert, animated: true)
    }
    
    func didSignUpSuccesfully() {
        isThereServiceRequest = false
        
        let alert = UIAlertController(title: "Success", message: "Signed up succesfully.", preferredStyle: .alert)
        alert.standardizeForAuth()
        self.present(alert, animated: true)
    }
    
    func didSignInSuccesfully() {
        isThereServiceRequest = false
        
        let alert = UIAlertController(title: "Success", message: "Signed in succesfully.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.pushViewController(MainTabBarController(), animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true) {
        }
    }
    
    func willRequestService() {
        isThereServiceRequest = true
    }
}

enum AuthViewControllerError: Error {
    case emptyInputFields
    case passwordsNoMatch
}

extension AuthViewControllerError: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyInputFields:
            return "Please fill all fields."
        case .passwordsNoMatch:
            return "Passwords do not match."
        }
    }
}



extension UIAlertController {
    func standardizeForAuth() {
        self.addAction(UIAlertAction(title: "OK", style: .default))
    }
}


