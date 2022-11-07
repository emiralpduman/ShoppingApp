//
//  ProfileView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 7.11.2022.
//

import UIKit
import SnapKit

protocol ProfileViewDelegate: AnyObject {
    func didTapSignOutButton()    
}

class ProfileView: UIView {
    var delegate: ProfileViewDelegate?
    
    
    var userName: String = "" {
        didSet {
            userNameValueLabel.text = userName
        }
    }
    var emailAddress: String = "" {
        didSet {
            emailAddressValueLabel.text = emailAddress
        }
    }
    
    var cartTotal: Double = 0 {
        didSet {
            cartTotalValueLabel.text = String(cartTotal)
        }
    }
    
    private var userNameValueLabel = UILabel()
    private var emailAddressValueLabel = UILabel()
    private var cartTotalValueLabel = UILabel()
    
    private lazy var userNameKeyLabel: UILabel = {
       let label = UILabel()
        label.text = "User Name:"
        
        return label
    }()
    private lazy var emailAddressKeyLabel: UILabel = {
       let label = UILabel()
        label.text = "E-mail:"
        
        return label
    }()
    private lazy var cartTotalKeyLabel: UILabel = {
       let label = UILabel()
        label.text = "Cart Total:"
        
        return label
    }()
    
    private lazy var userNameStack: UIStackView = {
       var stackView = UIStackView(arrangedSubviews: [userNameKeyLabel, userNameValueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var emailAddressStack: UIStackView = {
       var stackView = UIStackView(arrangedSubviews: [emailAddressKeyLabel, emailAddressValueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var cartTotalStack: UIStackView = {
       var stackView = UIStackView(arrangedSubviews: [cartTotalKeyLabel, cartTotalValueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        return stackView
    }()
    
    

    
    private lazy var containerStack: UIStackView = {
       var stackView = UIStackView(arrangedSubviews: [userNameStack, emailAddressStack, cartTotalStack])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = UIColor(named: "primary")
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchDown)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerStack)
        addSubview(signOutButton)
        
        containerStack.snp.makeConstraints() { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().inset(insetDefault)
            make.leading.equalToSuperview().inset(insetDefault)
        }
        
        signOutButton.snp.makeConstraints() { make in
            make.top.lessThanOrEqualTo(containerStack.snp.bottom)
            make.trailing.equalToSuperview().inset(insetDefault)
            make.leading.equalToSuperview().inset(insetDefault)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(insetDefault)
            make.height.lessThanOrEqualTo(UIScreen.main.bounds.height / 10)
        }
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapSignOutButton() {
        delegate?.didTapSignOutButton()
    }
    
    private let insetDefault: CGFloat = 10
    

}
