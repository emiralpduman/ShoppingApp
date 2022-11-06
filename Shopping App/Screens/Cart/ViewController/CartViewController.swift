//
//  CartViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit

class CartViewController: UIViewController {
    private let viewModel = CartViewModel()
    
    
    //MARK: - Properties
    private let mainView = CartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        title = "Cart"
        view.backgroundColor = .white
        
        mainView.setTableViewConnections(delegate: self, dataSource: self)
        
        mainView.ordersTableView.register(CartTableViewCell.self, forCellReuseIdentifier: "orderCell")
        mainView.ordersTableView.rowHeight = 100
        mainView.ordersTableView.allowsSelection = false

    }
    



}

// MARK: - Table View Protocol Conformance
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! CartTableViewCell
        cell.order = viewModel.orders[indexPath.row]
        
        return cell
    }
}
