//
//  OTPView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class OTPView: UIView {

    lazy var otpMessage: UILabel = {
        let label = UILabel()
        label.text = "Enter the OTP sent your mobile\nnumber 0902801****"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var otpTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "OTP"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var otpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONFIRM OTP", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(otpMessage)
        addSubview(otpTextField)
        addSubview(otpButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            otpMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            otpMessage.topAnchor.constraint(equalTo: topAnchor, constant:20),
            otpMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            otpMessage.heightAnchor.constraint(equalToConstant: 55),
            
            otpTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            otpTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            otpTextField.topAnchor.constraint(equalTo: otpMessage.bottomAnchor, constant: 35),
            otpTextField.heightAnchor.constraint(equalToConstant: 57),

           otpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
           otpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
           otpButton.topAnchor.constraint(equalTo: otpTextField.bottomAnchor, constant: 26),
           otpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
