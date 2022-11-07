//
//  OnboardingView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 7.11.2022.
//

import UIKit
import SnapKit

class OnboardingView: UIView {
    var featureImage: UIImage? {
        didSet {
            imageView.image = featureImage
        }
    }
    
    var featureText: String? {
        didSet {
            label.text = featureText
        }
    }
    
    private var imageView = UIImageView()
    private var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints() { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(insetDefault)
            make.trailing.equalToSuperview().inset(insetDefault)
            make.height.equalTo(UIScreen.main.bounds.height*(2/3))
        }
        
        label.snp.makeConstraints() { make in
            make.top.equalTo(imageView).offset(offsetDefault)
            make.trailing.equalToSuperview().inset(insetDefault)
            make.leading.equalToSuperview().inset(insetDefault)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let insetDefault: CGFloat = 10
    private let offsetDefault: CGFloat = 10

}
