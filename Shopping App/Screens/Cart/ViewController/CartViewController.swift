//
//  CartViewController.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit
import FirebaseAuth

class CartViewController: UIViewController, RealmReachable {
    private let viewModel = CartViewModel()
    
    
    //MARK: - Properties
    private let mainView = CartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        title = "Cart"
        view.backgroundColor = .white
        
        mainView.setTableViewConnections(delegate: self, dataSource: self)
        mainView.delegate = self
        
        mainView.ordersTableView.register(CartTableViewCell.self, forCellReuseIdentifier: "orderCell")
        mainView.ordersTableView.rowHeight = 100
        mainView.ordersTableView.allowsSelection = false
        
        mainView.cartTotal = viewModel.getCartTotal()

    }
    
    @objc private func updateTotal() {
        mainView.cartTotal = viewModel.getCartTotal()
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
        cell.delegate = self
        
        return cell
    }
}

// MARK: - CartTableViewCell Delegate Conformance
extension CartViewController: CartTableViewCellDelegate {
    func didTapCountStepper(senderOrder: OrderEntity) {
        let orders = viewModel.orders

        for index in 0..<orders.count {
            if orders[index]._id == senderOrder._id {
                orders[index].amount = senderOrder.amount
            }
        }

        updateTotal()
    }
}

// MARK: - CartView Delegate Conformance
extension CartViewController: CartViewDelegate {
    func didTapPayButton() {
        let alert = UIAlertController(title: "Payment", message: "Your order will be processed, continue?", preferredStyle: .alert)
        
        let confirmation = UIAlertAction(title: "Yes", style: .default) { _ in
            
            let user = Auth.auth().currentUser
            let userKey = user?.uid
            
            let userInDb = self.realm.object(ofType: UserEntity.self, forPrimaryKey: userKey)
            var orderIds: [String] = []
            
            for order in userInDb!.cart {
                orderIds.append(order._id)
            }
                        
            for id in orderIds {
                var order = self.realm.object(ofType: OrderEntity.self, forPrimaryKey: id)
                try! self.realm.write {
                    self.realm.delete(order!)
                }
            }
            
            let alert = UIAlertController(title: "Done!", message: "We received your order. Thank you. You will be directed main screen", preferredStyle: .alert)
            let approval = UIAlertAction(title: "OK", style: .default) {_ in
                self.navigationController?.pushViewController(MainTabBarController(), animated: true)
            }
            
            alert.addAction(approval)
            self.present(alert, animated: true)
            
        }
        
        let cancellation = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(confirmation)
        alert.addAction(cancellation)
        
        present(alert, animated: true)
    }
}


