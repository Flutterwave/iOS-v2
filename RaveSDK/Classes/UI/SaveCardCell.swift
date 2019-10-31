//
//  SaveCardCell.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 10/10/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit

class SaveCardCell: UITableViewCell {
   // @IBOutlet weak var maskCardLabel: UILabel!
   // @IBOutlet weak var brandImage: UIImageView!
   // @IBOutlet weak var contentContainer: UIView!
    
    lazy var contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var brandImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var maskCardLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(contentContainer)
        contentContainer.addSubview(brandImage)
        contentContainer.addSubview(maskCardLabel)
        setupConstriants()
    }
    
    func setupConstriants(){
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            contentContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            contentContainer.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            contentContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            maskCardLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 14),
            maskCardLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            brandImage.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -8),
            brandImage.widthAnchor.constraint(equalToConstant: 33),
            brandImage.heightAnchor.constraint(equalToConstant: 45),
            brandImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            maskCardLabel.trailingAnchor.constraint(equalTo: brandImage.leadingAnchor, constant: -49)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
