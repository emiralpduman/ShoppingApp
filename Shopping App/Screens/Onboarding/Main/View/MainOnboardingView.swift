//
//  MainOnboardingView.swift
//  Shopping App
//
//  Created by Emiralp Duman on 7.11.2022.
//

import UIKit

class MainOnboardingView: UIView {

    private lazy var scrollView: UIScrollView?
     private lazy var contentView: UIView?
     private lazy var pageControl: UIPageControl?
    
     private lazy var skipButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Skip", for: .normal)
         
         return button
     }()
    private lazy var prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        
        return button
    }()
     private lazy var nextButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Next", for: .normal)
         
         return button
     }()
}
