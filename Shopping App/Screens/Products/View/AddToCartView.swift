//
//  AddToCartView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 2.11.2022.
//

import UIKit
import SnapKit

protocol AddToCartViewDelegate: AnyObject {
    func addToCartView(_ view: AddToCartView, didTapStepper: UIStepper)
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
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Adding subviews
        addSubview(quantityStackView)
        quantityStackView.snp.makeConstraints() { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate Methods
    
    @objc private func didTapQuantityStepper(_ sender: UIStepper) {
        delegate?.addToCartView(self, didTapStepper: sender)
    }
    
    //Drawing constants
    private let stackViewSpacing: CGFloat = 10

}
