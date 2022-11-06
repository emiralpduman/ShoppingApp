//
//  CartView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit
import SnapKit

class CartView: UIView {
    
    // MARK: - Subviews
     lazy var ordersTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
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
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setTableViewConnections(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        ordersTableView.delegate = delegate
        ordersTableView.dataSource = dataSource
    }
}
