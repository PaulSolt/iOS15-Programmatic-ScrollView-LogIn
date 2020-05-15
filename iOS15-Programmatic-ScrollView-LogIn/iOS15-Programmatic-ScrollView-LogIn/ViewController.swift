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
//        scrollView.backgroundColor = .cyan
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.delaysContentTouches = false
        scrollView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = .systemPink
        return contentView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "kalen-emsley-mountain"))
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: imageHeight))
//        imageView.alpha = 0.5
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            passwordTextField,
            button,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        // TODO: create padding variable
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
        return stackView
    }()

    lazy var nameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Name"
        textField.delegate = self
        return textField
    }()

    lazy var passwordTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "blue-button"), for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.adjustsImageWhenHighlighted = true
        button.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonPressed(button: UIButton) {
        print("Log In!")
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        view.endEditing(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addScrollView()
        addImageView()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addStackView()
        
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
    
    func addStackView() {
        // Add all content to the contentView
        contentView.addSubview(stackView)
        
        // Auto-advanced to password when "Return" is pressed
        nameTextField.nextView = passwordTextField
        passwordTextField.nextView = nil // dismiss keyboard
        
        view.addConstraints([
            // Stack View for Content View
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Text Field Height
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
        ])
    }
    
    private func addImageView() {
        view.addSubview(imageView)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = textField as? NextView,
            let nextView = textField.nextView {
            DispatchQueue.main.async {
                nextView.becomeFirstResponder()
            }
            return true
        } else {
            DispatchQueue.main.async {
                textField.resignFirstResponder()
            }
            return true
        }
    }
}
