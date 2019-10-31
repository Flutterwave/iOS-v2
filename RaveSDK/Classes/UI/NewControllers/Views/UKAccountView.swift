//
//  UKAccountView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 11/10/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class UKAccountView: UIView {

    lazy var titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Click pay to continue"
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .center
           label.numberOfLines = 0
           label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
           return label
       }()
       
    
       
       lazy var accountPayButton: UIButton = {
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
           addSubview(accountPayButton)
           setupConstraints()
       }
       
       func setupConstraints(){
           NSLayoutConstraint.activate([
               titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
               titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
               titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
               titleLabel.heightAnchor.constraint(equalToConstant: 55),
               
               accountPayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
               accountPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
               accountPayButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
               accountPayButton.heightAnchor.constraint(equalToConstant: 50),
         ])
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       

}
