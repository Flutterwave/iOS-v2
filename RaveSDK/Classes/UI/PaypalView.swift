//
//  Paypal.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 20/03/2021.
//




import UIKit

class PaypalView: UIView {
   
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "NGN"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
   
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "user@gmail.com"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "You will be redirected to Paypal to complete this payment."
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    

    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Procced to", for: .normal)
        button.setTitleColor(UIColor(hex: "#193D82"), for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.setImage(UIImage(named: "paypal", in: Bundle.getResourcesBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: -220,bottom: 0,right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left:0,bottom: 0,right: -165)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        addSubview(currencyLabel)
         addSubview(amountLabel)
        addSubview(emailLabel)
        addSubview(instructionLabel)
        addSubview(payButton)
      
         setupConstraints()
     }
   
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            currencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            currencyLabel.topAnchor.constraint(equalTo: topAnchor, constant:40),
//            currencyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            amountLabel.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant:3),
            amountLabel.topAnchor.constraint(equalTo: currencyLabel.topAnchor, constant: -10),
//            amountLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            emailLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant:2),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),
         
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            instructionLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant:20),
            instructionLabel.heightAnchor.constraint(equalToConstant: 55),
            
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            payButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 40),
            payButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
