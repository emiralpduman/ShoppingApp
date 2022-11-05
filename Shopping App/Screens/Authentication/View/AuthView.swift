//
//  AuthView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func didValueChange(_ sender: UISegmentedControl)
    func didButtonPressed(_ sender: UIButton)
}

final class AuthView: UIView {
    // MARK: - Properties
    weak var delegate: AuthViewDelegate?
    var signingMode: SigningMode = .signIn {
        didSet {
            switch signingMode {
            case .signIn:
                userNameTextField.isHidden = true
                passwordRepeatTextField.isHidden = true
                signButton.setTitle("Sign-In", for: .normal)
            case .signUp:
                userNameTextField.isHidden = false
                passwordRepeatTextField.isHidden = false
                signButton.setTitle("Sign-Up", for: .normal)
            }
        }
    }
    
    
    // MARK: - Visual Elements
    lazy var userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your user name"
        textfield.isHidden = true
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your e-mail"
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your password"
        textfield.isSecureTextEntry = true
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    lazy var passwordRepeatTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Please enter your password again"
        textfield.isSecureTextEntry = true
        textfield.isHidden = true
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    private lazy var signingTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Sign In", "Sign Up"])
        segmentedControl.selectedSegmentIndex = 0
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
        button.setTitle("Sign-In", for: .normal)
        button.addTarget(self, action: #selector(didButtonTouchDown), for: .touchDown)
        return button
        
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView
        if #available(iOS 13, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .gray)
        }
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [signingTypeSegmentedControl, textFieldsStackView, activityIndicator, signButton])
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
        delegate?.didValueChange(signingTypeSegmentedControl)
    }
    
    @objc private func didButtonTouchDown() {
        delegate?.didButtonPressed(signButton)
    }
    
    
    // MARK:  - Drawing Constants
    private let defaultStackViewSpacing: CGFloat = 20
    private let defaultInset: CGFloat = 10
    
    enum SigningMode: Int {
        case signIn = 0, signUp
    }
}
