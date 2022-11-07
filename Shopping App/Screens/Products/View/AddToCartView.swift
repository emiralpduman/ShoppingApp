//
//  AddToCartView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 2.11.2022.
//

import UIKit
import SnapKit

protocol AddToCartViewDelegate: AnyObject {
    func addToCartView(_ view: AddToCartView, didTapQuantityStepper: UIStepper)
    func addToCartView(_ view: AddToCartView, didTapAddButton: UIButton)
    func didSwipeDown()

}

final class AddToCartView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: AddToCartViewDelegate?
    
    var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "Amount: \(quantity)"
        }
    }
    
    // MARK: - Visual Elements
    
    private lazy var quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.addTarget(self, action: #selector(didTapQuantityStepper), for: .valueChanged)
        return stepper
    }()
    private lazy var quantityLabel: UILabel = {
       let label = UILabel()
        label.text = "Amount: \(quantity)"
        return label
    }()
    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quantityLabel, quantityStepper])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = stackViewSpacing
        return stackView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "primary")
        button.tintColor = .white
        return button
    }()
    
    private lazy var addToCartStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quantityStackView, addButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
        tap.direction = .down
        tap.numberOfTouchesRequired = 1
        addGestureRecognizer(tap)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        //Adding subviews
        addSubview(addToCartStackView)
        addToCartStackView.snp.makeConstraints() { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate Methods
    
    @objc private func didTapQuantityStepper(_ sender: UIStepper) {
        delegate?.addToCartView(self, didTapQuantityStepper: sender)
    }
    @objc private func didTapAddButton(_ sender: UIButton) {
        delegate?.addToCartView(self, didTapAddButton: sender)
    }
    @objc private func didSwipeDown() {
        delegate?.didSwipeDown()
    }
    
    //Drawing constants
    private let stackViewSpacing: CGFloat = 10

}
