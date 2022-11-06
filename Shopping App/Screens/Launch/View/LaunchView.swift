//
//  LaunchView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit
import SnapKit

class LaunchView: UIView {
    // MARK: - Subviews
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        
        return imageView
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        
        return indicator
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppIconImageView()
        setupActivityIndicatorView()
        activityIndicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Methods
    private func setupAppIconImageView() {
        addSubview(appIconImageView)
        
        appIconImageView.snp.makeConstraints() { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints() { make in
            make.centerX.equalTo(appIconImageView)
            make.top.equalTo(appIconImageView.snp.bottom).offset(activityIndicatorOffset)
        }
        
    }
    
    // MARK: - Drawing Constant
    private let activityIndicatorOffset: CGFloat = 10

}
