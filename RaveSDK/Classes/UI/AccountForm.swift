//
//  AccountForm.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class AccountForm: UIView {

    lazy var accountImageView: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Phone number"
        text.keyboardType = .phonePad
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var accountNumberTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Account number"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.keyboardType = .numberPad
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var dobTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Date of Birth"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.isHidden = true
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var accountBvn: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "BVN"
        text.isHidden = true
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var accountPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var goBack: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GO BACK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 14
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(accountImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(accountNumberTextField)
        stackView.addArrangedSubview(dobTextField)
        stackView.addArrangedSubview(accountBvn)
        addSubview(accountPayButton)
        addSubview(goBack)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            accountImageView.topAnchor.constraint(equalTo: topAnchor, constant:25),
            accountImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountImageView.heightAnchor.constraint(equalToConstant: 44),
            accountImageView.widthAnchor.constraint(equalToConstant: 129),
            
            stackView.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 31),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            
            accountPayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            accountPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            accountPayButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 19),
            accountPayButton.heightAnchor.constraint(equalToConstant: 50),
            
            goBack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            goBack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            goBack.topAnchor.constraint(equalTo: accountPayButton.bottomAnchor, constant: 8),
            //goBack.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
