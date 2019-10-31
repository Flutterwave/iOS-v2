//
//  MpesaPendingView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class MpesaPendingView: UIView {
    lazy var mpesaPendingLabel: UILabel = {
        let label = UILabel()
        label.text = "A push notification has been sent to your phone, please complete the transaction by entering your pin. Please do not close this page until transaction is completed"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 126).isActive = true
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var mpesaPendingNoNotification: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.text = "Didnt get the push notification? Click here"
        label.heightAnchor.constraint(equalToConstant: 126).isActive = true
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(mpesaPendingLabel)
        stackView.addArrangedSubview(mpesaPendingNoNotification)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant:71),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
