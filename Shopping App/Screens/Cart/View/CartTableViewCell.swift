//
//  CartTableViewCell.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit
import Kingfisher
import SnapKit

protocol CartTableViewCellDelegate: AnyObject {
    func didTapCountStepper(senderOrder: OrderEntity)
}


class CartTableViewCell: UITableViewCell {
    // MARK: -- Properties
    var order: OrderEntity? {
        didSet {
            if let order = order {
                productImageView.kf.setImage(with: URL(string: order.productImage))
                productTitleLabel.text = order.productLabel
                productOrderAmountLabel.text = String(order.amount)
                productPriceLabel.text = "\(order.price) TL"
                
            }
        }
    }
    
    weak var delegate: CartTableViewCellDelegate?
    
    // MARK: - Initialization    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContainerStackView()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        setupContainerStackView()
        
//        let label = UILabel()
//        label.text = "deneme"
//        addSubview(label)
//        label.snp.makeConstraints() { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        
    }
    
    // MARK: -- Subviews
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var productTitleLabel = UILabel()
    
    private var productPriceLabel = UILabel()
    
    private lazy var productInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productTitleLabel, productPriceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    
    private var productOrderAmountLabel = UILabel()
    
    lazy var orderCountStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.addTarget(self, action: #selector(didTapCountStepper), for: .valueChanged)
        return stepper
    }()
    
    private lazy var orderAmountAndStepperStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [orderCountStepper, productOrderAmountLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    
    private lazy var tableCellContainerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productImageView, productInfoStack, orderAmountAndStepperStack])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    


    // MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func didTapCountStepper() {
        if let order = order {
            order.amount = Int(orderCountStepper.value)
            productOrderAmountLabel.text = String(Int(orderCountStepper.value))
            delegate?.didTapCountStepper(senderOrder: order)
        }
        
    }
    
    private func setupContainerStackView() {
        contentView.addSubview(tableCellContainerStack)
            
        tableCellContainerStack.snp.makeConstraints() { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }


}
