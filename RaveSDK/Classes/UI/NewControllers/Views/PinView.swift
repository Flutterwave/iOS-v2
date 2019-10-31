//
//  PinView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 06/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class PinView: UIView {
    
    lazy var titleInfo: UILabel = {
        let label = UILabel()
        label.text = "Please enter your 4-digit card\npin to authorize this payment"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let pins:[UIView] = Array(1...4).map { (item) -> UIView in
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .white
        return view
    }
    
    lazy var hiddenPinTextField: UITextField = {
        let text = UITextField()
        text.keyboardType = .numberPad
        return text
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: pins)
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var pinContinueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleInfo)
        addSubview(stackView)
        addSubview(hiddenPinTextField)
        addSubview(pinContinueButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleInfo.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleInfo.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 45),
            
            pinContinueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pinContinueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pinContinueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            pinContinueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
