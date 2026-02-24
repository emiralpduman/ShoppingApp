//
//  LaunchViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit

class LaunchViewController: UIViewController {
    // MARK: - Properties
    private let mainView = LaunchView()
    private let viewModel = LaunchViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchProducts()
        
        title = "Welcome"
        view = mainView
        view.backgroundColor = UIColor(named: "secondary")
    }

}

// MARK: - View Model Delegate Conformance
extension LaunchViewController: LaunchViewModelDelegate {
    func willFetchProducts() {
        mainView.activityIndicatorView.startAnimating()
    }
    
    func didErrorOccur(_ error: Error) {
        mainView.activityIndicatorView.stopAnimating()
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.standardizeForAuth()
        self.present(alert, animated: true)
    }
    
    func didFetchProducts() {
        mainView.activityIndicatorView.stopAnimating()
    }
    
    
}
