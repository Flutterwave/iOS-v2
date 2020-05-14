//
//  HeaderView.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 14/08/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit

class RavePayHeaderView: UIView {
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowButton:UIButton = {
        let button = UIButton(type: .custom)
        //UIImage(named: "rave_up_arrow")
        button.setImage(UIImage(named: "rave_up_arrow", in: Bundle.getResourcesBundle()!, compatibleWith: nil), for: .normal)
        button.tintColor = UIColor(hex: "#647482")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let button:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(arrowButton)
        addSubview(button)
        setupConstraints()
    }
    
    func setupConstraints(){
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 22).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        arrowButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -22).isActive = true
        arrowButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
        self.addShadow(offset: CGSize(width: 0, height: 1), color: .black, radius: 5, opacity: 0.15)
    }
}
