//
//  LaunchView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 6.11.2022.
//

import UIKit

class LaunchView: UIView {
    // MARK: - Subviews
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        
        return imageView
    }()
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        
        return indicator
    }()



}
