//
//  HowView.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 05/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class HowView: UIView {
    lazy var howLabel: UILabel = {
        let label = UILabel()
        label.text = "How would\nyou like to pay?"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F5A623")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(howLabel)
        addSubview(underLineView)
        setupConstriant()
    }
    
    func setupConstriant(){
        NSLayoutConstraint.activate([
            howLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70),
            howLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            howLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -62),
            howLabel.heightAnchor.constraint(equalToConstant: 86),
            
            underLineView.leadingAnchor.constraint(equalTo: howLabel.leadingAnchor),
            underLineView.topAnchor.constraint(equalTo: howLabel.bottomAnchor, constant: 20),
            underLineView.heightAnchor.constraint(equalToConstant: 3),
            underLineView.widthAnchor.constraint(equalToConstant: 118),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
