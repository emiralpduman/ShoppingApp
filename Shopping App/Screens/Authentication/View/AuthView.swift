//
//  AuthView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func didChangeValueOf(_ sender: UISegmentedControl)}

final class AuthView: UIView {
    // MARK: - Properties
    weak var delegate: AuthViewDelegate?
    var signingMode: SigningMode = .signIn
    
    
    // MARK: - Visual Elements
    private lazy var userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your user name"
        textfield.isHidden = true
        return textfield
    }()
    private lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your e-mail"
        return textfield
    }()
    private lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your password"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    private lazy var passwordRepeatTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your password again"
        textfield.isSecureTextEntry = true
        textfield.isHidden = true
        return textfield
    }()
    private lazy var signingTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Sign In", "Sign Up"])
        segmentedControl.selectedSegmentIndex = signingMode.rawValue
        segmentedControl.addTarget(self, action: #selector(didSegmentedControlValueChange), for: .valueChanged)
        return segmentedControl
    }()
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, emailTextField, passwordTextField, passwordRepeatTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = defaultStackViewSpacing
        return stackView
    }()
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        
    }()
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [signingTypeSegmentedControl, textFieldsStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = defaultStackViewSpacing
        return stackView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints() { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(defaultInset)
            make.trailing.equalToSuperview().inset(defaultInset)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc private func didSegmentedControlValueChange() {
        guard let modeIndex = SigningMode(rawValue: signingTypeSegmentedControl.selectedSegmentIndex) else {
            fatalError("Singing mode rawValue returns no case")
        }
        signingMode = modeIndex
        switch signingMode {
        case .signIn:
            userNameTextField.isHidden = true
            passwordRepeatTextField.isHidden = true
        case .signUp:
            userNameTextField.isHidden = false
            passwordRepeatTextField.isHidden = false
        }
        delegate?.didChangeValueOf(signingTypeSegmentedControl)
    }
    
    // MARK:  - Drawing Constants
    private let defaultStackViewSpacing: CGFloat = 20
    private let defaultInset: CGFloat = 10
    
    enum SigningMode: Int {
        case signIn = 0, signUp
    }
}
