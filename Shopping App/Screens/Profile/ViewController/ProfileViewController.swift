//
//  ProfileViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 7.11.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    private let mainView = ProfileView()

    private var viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = mainView
        title = "Profile"
        view.backgroundColor = .white
        mainView.delegate = self

        mainView.userName = viewModel.user.userName
        mainView.emailAddress = viewModel.user.emailAddress
        mainView.cartTotal = viewModel.cartTotal
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didTapSignOutButton() {
        let alert = UIAlertController(title: "Are you sure?", message: "You are about to sign-out, continue?", preferredStyle: .alert)
        let confirmation = UIAlertAction(title: "Yes", style: .default) { _ in
            do {
                try Auth.auth().signOut()
            } catch {
                print("Failed to sign out: \(error.localizedDescription)")
            }
            self.navigationController?.pushViewController(AuthViewController(), animated: true)
        }
        let cancellation = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(confirmation)
        alert.addAction(cancellation)
        present(alert, animated: true)
    }
}
