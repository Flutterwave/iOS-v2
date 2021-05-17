//
//  DebitCardView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 05/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class DebitCardView: UIView {

    lazy var titleInfo: UILabel = {
        let label = UILabel()
        label.text = "Enter your card information."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var cardfieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var cardNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "CARD NUMBER"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#999999")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var cardExpiryTitle: UILabel = {
        let label = UILabel()
        label.text = "VALID TILL"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#999999")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var cardCVVTitle: UILabel = {
        let label = UILabel()
        label.text = "CVV"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#999999")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var cardNumberTextField: VSTextField = {
        let text = VSTextField()
        text.setFormatting("xxxx xxxx xxxx xxxx xxxx", replacementChar: "x")
        text.placeholder = "4242 4242 4242 4242"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var cardExpiry: VSTextField = {
        let text = VSTextField()
        text.setFormatting("xx/xx", replacementChar: "x")
        text.placeholder = "MM / YY"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var cardCVV: VSTextField = {
        let text = VSTextField()
        text.setFormatting("xxxx", replacementChar: "x")
        text.placeholder = "123"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var horizontalDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex:"#E0E0E0")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var verticalDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex:"#E0E0E0")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rememberCardCheck: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rave_check_box",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var rememberCardText: UILabel = {
        let label = UILabel()
        label.text = "Remember this card next time"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#4A4A4A")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    lazy var cardPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var whatsCVVButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("What is this?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor(hex: "#636569"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
		let bundle = Bundle.getResourcesBundle()
		print(bundle)
        backgroundColor = UIColor(hex: "#F2F2F2")
        addSubview(titleInfo)
        addSubview(cardfieldContainer)
        
         addSubview(rememberCardCheck)
         addSubview(rememberCardText)
         addSubview(cardPayButton)
        
        cardfieldContainer.addSubview(cardNumberTitle)
       cardfieldContainer.addSubview(cardNumberTextField)
        cardfieldContainer.addSubview(cardExpiryTitle)
        cardfieldContainer.addSubview(cardExpiry)
        cardfieldContainer.addSubview(cardCVVTitle)
        cardfieldContainer.addSubview(cardCVV)
        cardfieldContainer.addSubview(horizontalDividerView)
        cardfieldContainer.addSubview(verticalDividerView)
        cardfieldContainer.addSubview(whatsCVVButton)
        setupConstriant()
    }
    
    func setupConstriant(){
        NSLayoutConstraint.activate([
            titleInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleInfo.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleInfo.heightAnchor.constraint(equalToConstant: 55),
            
            cardfieldContainer.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 24),
            cardfieldContainer.leadingAnchor.constraint(equalTo: titleInfo.leadingAnchor),
            cardfieldContainer.trailingAnchor.constraint(equalTo: titleInfo.trailingAnchor),
            cardfieldContainer.heightAnchor.constraint(equalToConstant: 153),
            
            cardNumberTitle.leadingAnchor.constraint(equalTo: cardfieldContainer.leadingAnchor, constant: 18),
            cardNumberTitle.topAnchor.constraint(equalTo: cardfieldContainer.topAnchor, constant: 18),
            cardNumberTextField.topAnchor.constraint(equalTo: cardNumberTitle.bottomAnchor, constant: 4
            ),
            cardNumberTextField.leadingAnchor.constraint(equalTo: cardNumberTitle.leadingAnchor),
            cardNumberTextField.trailingAnchor.constraint(equalTo: cardfieldContainer.trailingAnchor, constant: -18),

            horizontalDividerView.leadingAnchor.constraint(equalTo: cardfieldContainer.leadingAnchor),
            horizontalDividerView.trailingAnchor.constraint(equalTo: cardfieldContainer.trailingAnchor),
            horizontalDividerView.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant:5.5),
            horizontalDividerView.heightAnchor.constraint(equalToConstant: 0.5),

            cardExpiryTitle.leadingAnchor.constraint(equalTo: cardfieldContainer.leadingAnchor, constant: 20),
             cardExpiryTitle.topAnchor.constraint(equalTo: horizontalDividerView.bottomAnchor, constant: 18),
             cardExpiry.topAnchor.constraint(equalTo: cardExpiryTitle.bottomAnchor, constant: 4),
             cardExpiry.leadingAnchor.constraint(equalTo: cardExpiryTitle.leadingAnchor),
             cardExpiry.bottomAnchor.constraint(equalTo: cardfieldContainer.bottomAnchor, constant: -8),

             verticalDividerView.centerXAnchor.constraint(equalTo: cardfieldContainer.centerXAnchor),
             verticalDividerView.topAnchor.constraint(equalTo: horizontalDividerView.bottomAnchor),
             verticalDividerView.bottomAnchor.constraint(equalTo: cardfieldContainer.bottomAnchor),
             verticalDividerView.widthAnchor.constraint(equalToConstant: 0.5),

             cardExpiry.trailingAnchor.constraint(equalTo: verticalDividerView.leadingAnchor, constant: -20),

            cardCVVTitle.leadingAnchor.constraint(equalTo: verticalDividerView.trailingAnchor, constant: 20),
            cardCVVTitle.topAnchor.constraint(equalTo: cardExpiryTitle.topAnchor),

            cardCVV.leadingAnchor.constraint(equalTo: cardCVVTitle.leadingAnchor),
            cardCVV.topAnchor.constraint(equalTo: cardCVVTitle.bottomAnchor, constant: 4),
            cardCVV.trailingAnchor.constraint(equalTo: cardfieldContainer.trailingAnchor, constant: -20),
            cardCVV.bottomAnchor.constraint(equalTo: cardfieldContainer.bottomAnchor, constant: -8),

            whatsCVVButton.leadingAnchor.constraint(equalTo: cardCVVTitle.trailingAnchor, constant: 15),
            whatsCVVButton.topAnchor.constraint(equalTo: cardCVVTitle.topAnchor),
            whatsCVVButton.heightAnchor.constraint(equalToConstant: 15),
            whatsCVVButton.trailingAnchor.constraint(equalTo: cardfieldContainer.trailingAnchor, constant: -20),
            
            rememberCardCheck.leadingAnchor.constraint(equalTo: cardfieldContainer.leadingAnchor),
            rememberCardCheck.topAnchor.constraint(equalTo: cardfieldContainer.bottomAnchor, constant:14),
            
            rememberCardCheck.heightAnchor.constraint(equalToConstant: 32),
            rememberCardCheck.widthAnchor.constraint(equalToConstant: 39),
            
            
            rememberCardText.leadingAnchor.constraint(equalTo: rememberCardCheck.trailingAnchor, constant: 8),
            rememberCardText.centerYAnchor.constraint(equalTo: rememberCardCheck.centerYAnchor),
            
            cardPayButton.leadingAnchor.constraint(equalTo: cardfieldContainer.leadingAnchor),
            cardPayButton.trailingAnchor.constraint(equalTo: cardfieldContainer.trailingAnchor),
            cardPayButton.topAnchor.constraint(equalTo: rememberCardCheck.bottomAnchor, constant: 20),
            cardPayButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            rememberCardText.bottomAnchor.constraint(equalTo: cardPayButton.topAnchor, constant: -8)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
