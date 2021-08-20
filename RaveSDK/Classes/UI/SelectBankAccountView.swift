
//
//  SelectBankAccountView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class SelectBankAccountView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please select your bank"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var otherBanksTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.placeholder = "Select a Bank"
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(otherBanksTextField)
      
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            otherBanksTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            otherBanksTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            otherBanksTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            otherBanksTextField.heightAnchor.constraint(equalToConstant: 57),

            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
