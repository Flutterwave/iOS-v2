//
//  MobileMoneyRW.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 10/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class MobileMoneyRW: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your phone number to\nbegin payment."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var mobileMoneyRWPhone: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Phone number"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var mobileMoneyRWPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(mobileMoneyRWPhone)
        addSubview(mobileMoneyRWPayButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            mobileMoneyRWPhone.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyRWPhone.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyRWPhone.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            mobileMoneyRWPhone.heightAnchor.constraint(equalToConstant: 57),
            
            mobileMoneyRWPayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyRWPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyRWPayButton.topAnchor.constraint(equalTo: mobileMoneyRWPhone.bottomAnchor, constant: 26),
            mobileMoneyRWPayButton.heightAnchor.constraint(equalToConstant: 50),
      ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
}
