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
        let image = UIImage(named: "AppIcon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        
        return indicator
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppIconImageView()
        setupActivityIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    // MARK: - Methods
    private func setupAppIconImageView() {
        addSubview(appIconImageView)
        
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth * appIconSizeToScreenSizeRatio
        let height = width
        
        appIconImageView.snp.makeConstraints() { make in
            make.center.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints() { make in
            make.centerX.equalTo(appIconImageView)
            make.top.equalTo(appIconImageView.snp.bottom).offset(activityIndicatorOffset)
        }
        
    }
    
    // MARK: - Drawing Constants
    private let activityIndicatorOffset: CGFloat = 10
    private let appIconSizeToScreenSizeRatio: CGFloat = 1/2

}
