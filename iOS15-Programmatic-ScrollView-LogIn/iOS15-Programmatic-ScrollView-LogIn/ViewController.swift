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
        scrollView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemPink
        return contentView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "kalen-emsley-mountain"))
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: imageHeight))
        imageView.alpha = 0.5
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        // TODO: create padding variable
        stackView.directionalLayoutMargins = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }()

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Name"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addScrollView()
        addImageView()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Add all content to the contentView
        contentView.addSubview(stackView)
        
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

            // Stack View for Content View
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

        ])
    }
    
    private func addImageView() {
        view.addSubview(imageView)
    }
}

