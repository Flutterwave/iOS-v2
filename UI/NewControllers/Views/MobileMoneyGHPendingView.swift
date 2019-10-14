//
//  MobileMoneyGHPendingView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 09/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class MobileMoneyGHPendingView: UIView {

    lazy var mobileMoneyPendingLabel: UILabel = {
        let label = UILabel()
        label.text = "A push notification has been sent to your phone, please complete the transaction by entering your pin. Please do not close this page until transaction is completed"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mobileMoneyPendingLabel)
       
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            mobileMoneyPendingLabel.topAnchor.constraint(equalTo: topAnchor, constant:71),
            mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
