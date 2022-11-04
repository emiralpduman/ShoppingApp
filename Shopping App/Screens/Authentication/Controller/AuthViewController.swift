//
//  AuthViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    private var mainView = AuthView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign-In"
        view = mainView
        
        mainView.delegate = self

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

extension AuthViewController: AuthViewDelegate {
    func didChangeValueOf(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        title = sender.titleForSegment(at: selectedIndex)
    }
}
