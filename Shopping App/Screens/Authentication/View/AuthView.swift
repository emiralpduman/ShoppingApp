//
//  AuthView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import UIKit

class AuthView: UIView {
    // MARK: - Visual Elements
    private var userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your user name"
        textfield.isHidden = true
        return textfield
    }()
    private var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your e-mail"
        return textfield
    }()
    private lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your e-mail"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    private lazy var passwordRepeatTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your e-mail"
        textfield.isSecureTextEntry = true
        textfield.isHidden = true
        return textfield
    }()
    private lazy var signingTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Sign In", "Sign Up"])
        segmentedControl.addTarget(self, action: #selector(didSegmentedControlValueChange), for: .valueChanged)
        return segmentedControl
    }()
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, passwordRepeatTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc private func didSegmentedControlValueChange() {
        print("Time to hide unncessary views")
    }
}
