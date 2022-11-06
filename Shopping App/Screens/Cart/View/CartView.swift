//
//  CartView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit
import SnapKit

class CartView: UIView {
    var cartTotal: Double = 0 {
        didSet {
            totalNumberLabel.text = "\(cartTotal) TL"
        }
    }
    
    
    
    // MARK: - Subviews
     lazy var ordersTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    lazy var totalLabel: UILabel = {
       let label = UILabel()
        label.text = "Total:"
        
        return label
    }()
    
    lazy var totalNumberLabel: UILabel = {
        let label = UILabel()
        label.text = String(cartTotal)
        
        return label
    }()
    
    lazy var totalStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [totalLabel, totalNumberLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(didTapPayButton), for: .touchDown)
        
        return button
    }()
    
    lazy var paymentStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [totalStack, payButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupTableView() {
        addSubview(ordersTableView)
        
        ordersTableView.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(paymentStack)
        
        paymentStack.snp.makeConstraints() { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.top.equalTo(ordersTableView.snp.bottom)
        }

        

    }
    
    func setTableViewConnections(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        ordersTableView.delegate = delegate
        ordersTableView.dataSource = dataSource
    }
    
    @objc func didTapPayButton() {
        print("payment is done")
    }
}
