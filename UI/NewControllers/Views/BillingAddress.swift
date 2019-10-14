//
//  BillingAddress.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class BillingAddress: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your billing address"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    lazy var billingAddressTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Address"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        return text
    }()
    lazy var cityTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "City"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
         text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        return text
    }()
    lazy var stateTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "State"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
         text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        return text
    }()
    lazy var zipCodeTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Zip code / PostCode"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
         text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        return text
    }()
    lazy var countryTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Country"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
         text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        return text
    }()
    lazy var billingContinueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(billingContinueButton)
        
        stackView.addArrangedSubview(billingAddressTextField)
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)
        
        firstStackView.addArrangedSubview(cityTextField)
        firstStackView.addArrangedSubview(stateTextField)
        
        secondStackView.addArrangedSubview(zipCodeTextField)
        secondStackView.addArrangedSubview(countryTextField)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:35),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            
            billingContinueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            billingContinueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            billingContinueButton.heightAnchor.constraint(equalToConstant: 57),
            billingContinueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 42)
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
