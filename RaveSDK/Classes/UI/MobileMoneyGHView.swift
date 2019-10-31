//
//  MobileMoneyGHView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class MobileMoneyGHView: UIView {
    lazy var mobileMoneyTitle: UILabel = {
        let label = UILabel()
        label.text = "Please Dial *170#, click on Pay and wait for\ninstructions on the next screen"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var mobileMoneyChooseNetwork: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Choose Network"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var mobileMoneyPhoneNumber: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Phone Number"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.keyboardType = .phonePad
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var mobileMoneyVoucher: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Voucher"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.keyboardType = .phonePad
        text.isHidden = true
        text.heightAnchor.constraint(equalToConstant: 57).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var mobileMoneyPay: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
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
        addSubview(mobileMoneyTitle)
        addSubview(stackView)
        stackView.addArrangedSubview(mobileMoneyChooseNetwork)
        stackView.addArrangedSubview(mobileMoneyVoucher)
        stackView.addArrangedSubview(mobileMoneyPhoneNumber)
        stackView.addArrangedSubview(mobileMoneyPay)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            mobileMoneyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            mobileMoneyTitle.topAnchor.constraint(equalTo: topAnchor, constant:20),
            mobileMoneyTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            mobileMoneyTitle.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.topAnchor.constraint(equalTo: mobileMoneyTitle.bottomAnchor, constant: 37),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
