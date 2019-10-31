//
//  MPesaView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class MPesaBusinessView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please complete your transaction on M-PESA using the following details:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    lazy var business: UILabel = {
        let label = UILabel()
        label.text = "Business Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var mpesaBusinessNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var accountNumber: UILabel = {
        let label = UILabel()
        label.text = "Account Number"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var mpesaAccountNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(business)
        addSubview(mpesaBusinessNumber)
        addSubview(accountNumber)
        addSubview(mpesaAccountNumber)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            business.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            business.centerXAnchor.constraint(equalTo: centerXAnchor),
            mpesaBusinessNumber.topAnchor.constraint(equalTo: business.bottomAnchor, constant: 14),
            mpesaBusinessNumber.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            accountNumber.topAnchor.constraint(equalTo: mpesaBusinessNumber.bottomAnchor, constant: 40),
            accountNumber.centerXAnchor.constraint(equalTo: centerXAnchor),
            mpesaAccountNumber.topAnchor.constraint(equalTo: accountNumber.bottomAnchor, constant: 14),
            mpesaAccountNumber.centerXAnchor.constraint(equalTo: centerXAnchor),
      
    ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
