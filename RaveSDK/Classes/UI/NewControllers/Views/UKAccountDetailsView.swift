//
//  UKAccountDetailsView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 11/10/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class UKAccountDetailsView: UIView {

   lazy var titleLabel: UILabel = {
             let label = UILabel()
             label.text = "Please complete this transaction on your Mobile\nBanking App or Online Banking platform using the\nfollowing details:"
             label.translatesAutoresizingMaskIntoConstraints = false
             label.textAlignment = .center
             label.numberOfLines = 0
             label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
             return label
         }()
         
        lazy var beneficiaryNameLabel: UILabel = {
            let label = UILabel()
            label.text = "Beneficiary Name"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            return label
        }()
        lazy var beneficiaryNameLabelVlaue: UILabel = {
               let label = UILabel()
               label.text = ""
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .right
               label.numberOfLines = 0
               label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                   return label
        }()
         lazy var amountLabel: UILabel = {
             let label = UILabel()
             label.text = "Amount"
             label.translatesAutoresizingMaskIntoConstraints = false
             label.textAlignment = .left
             label.numberOfLines = 0
             label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
             return label
         }()
         lazy var amountValue: UILabel = {
                let label = UILabel()
                label.text = ""
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .right
                label.numberOfLines = 0
                label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                    return label
         }()
    
        lazy var accountNumberLabel: UILabel = {
            let label = UILabel()
            label.text = "Account Number"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            return label
        }()
        lazy var accountNumberValue: UILabel = {
               let label = UILabel()
               label.text = ""
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .right
               label.numberOfLines = 0
               label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                   return label
        }()
        lazy var sortCodeLabel: UILabel = {
            let label = UILabel()
            label.text = "Sort Code"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            return label
        }()
        lazy var sortCodeValue: UILabel = {
               let label = UILabel()
               label.text = ""
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .right
               label.numberOfLines = 0
               label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                   return label
        }()
        lazy var referenceNumberLabel: UILabel = {
            let label = UILabel()
            label.text = "Account Number"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            return label
        }()
        lazy var referenceNumberValue: UILabel = {
               let label = UILabel()
               label.text = ""
               label.translatesAutoresizingMaskIntoConstraints = false
               label.textAlignment = .right
               label.numberOfLines = 0
               label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                   return label
        }()
        
         lazy var accountContinueButton: UIButton = {
             let button = UIButton(type: .system)
             button.setTitle("I have completed this payment", for: .normal)
             button.setTitleColor(.black, for: .normal)
             button.backgroundColor = UIColor(hex: "#F5A623")
             button.layer.cornerRadius = 4
             button.translatesAutoresizingMaskIntoConstraints = false
             return button
         }()
    

         override init(frame: CGRect) {
             super.init(frame: frame)
             addSubview(titleLabel)
            addSubview(beneficiaryNameLabel)
            addSubview(beneficiaryNameLabelVlaue)
            addSubview(amountLabel)
            addSubview(amountValue)
            addSubview(accountNumberLabel)
            addSubview(accountNumberValue)
            addSubview(sortCodeLabel)
            addSubview(sortCodeValue)
            addSubview(referenceNumberLabel)
            addSubview(referenceNumberValue)
            addSubview(accountContinueButton)
            setupConstraints()
         }
         
         func setupConstraints(){
             NSLayoutConstraint.activate([
                 titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
                 titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
                 titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
                 titleLabel.heightAnchor.constraint(equalToConstant: 55),
                 
                 beneficiaryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                 beneficiaryNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                 
                 beneficiaryNameLabelVlaue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
                 beneficiaryNameLabelVlaue.centerYAnchor.constraint(equalTo: beneficiaryNameLabel.centerYAnchor),
                 
                 amountLabel.leadingAnchor.constraint(equalTo:beneficiaryNameLabel.leadingAnchor),
                 amountLabel.topAnchor.constraint(equalTo: beneficiaryNameLabel.bottomAnchor, constant: 10),
                 
                 amountValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
                 amountValue.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
                 
                 accountNumberLabel.leadingAnchor.constraint(equalTo:amountLabel.leadingAnchor),
                 accountNumberLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
                 
                 accountNumberValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
                 accountNumberValue.centerYAnchor.constraint(equalTo: accountNumberLabel.centerYAnchor),
                 
                 sortCodeLabel.leadingAnchor.constraint(equalTo:accountNumberLabel.leadingAnchor),
                 sortCodeLabel.topAnchor.constraint(equalTo: accountNumberLabel.bottomAnchor, constant: 10),
                 
                 sortCodeValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
                 sortCodeValue.centerYAnchor.constraint(equalTo: sortCodeLabel.centerYAnchor),
                 
                 referenceNumberLabel.leadingAnchor.constraint(equalTo:sortCodeLabel.leadingAnchor),
                 referenceNumberLabel.topAnchor.constraint(equalTo: sortCodeLabel.bottomAnchor, constant: 10),
                 
                 referenceNumberValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
                 referenceNumberValue.centerYAnchor.constraint(equalTo: referenceNumberLabel.centerYAnchor),
                 
                 accountContinueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                 accountContinueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                 accountContinueButton.topAnchor.constraint(equalTo: referenceNumberValue.bottomAnchor, constant: 16),
                 accountContinueButton.heightAnchor.constraint(equalToConstant: 50),
           ])
         }
         
         required init?(coder aDecoder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
         


}
