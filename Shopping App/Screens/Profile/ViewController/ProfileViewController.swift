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
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: ProfileViewDelegate {
    func didTapSignOutButton() {
        let alert = UIAlertController(title: "Are you sure?", message: "You are about to sign-out, continue?", preferredStyle: .alert)
        let confirmation = UIAlertAction(title: "Yes", style: .default) { _ in
            try! Auth.auth().signOut()
            self.navigationController?.pushViewController(AuthViewController(), animated: true)
            


        }
        let cancellation = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(confirmation)
        alert.addAction(cancellation)
        present(alert, animated: true)
    }
    
    
}
