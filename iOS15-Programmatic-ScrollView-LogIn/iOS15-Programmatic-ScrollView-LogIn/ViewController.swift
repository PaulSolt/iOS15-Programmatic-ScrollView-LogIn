//
//  ViewController.swift
//  iOS15-Programmatic-ScrollView-LogIn
//
//  Created by Paul Solt on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageHeight: CGFloat = 300
    let buttonHeight: CGFloat = 60
    let textFieldHeight: CGFloat = 40
    
    // Lazy properties (future extract to custom classes to reuse among screens)
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .cyan
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemPink
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addScrollView()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        view.addConstraints([
            // superview (Storyboard) = view
            
            // Safe area = under the time
            // Scroll View Constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Content View Constraints (Prevents content from being squished to intrinsic content size)
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            contentView.heightAnchor.constraint(equalTo: view.heightAnchor),

            
        ])
    }
}

