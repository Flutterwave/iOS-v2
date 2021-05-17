//
//  SaveCardViewController.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 10/10/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit
protocol CardSelect:class {
    func cardSelected(card:SavedCard?)
}

class SaveCardViewController: UIViewController {
    var savedCards:[SavedCard]?
  //  @IBOutlet weak var saveCardTable: UITableView!
    lazy var saveCardTable:UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    let raveCardClient = RaveCardClient()
    weak var delegate:CardSelect?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        view.addSubview(saveCardTable)
        
        saveCardTable.delegate = self
        saveCardTable.dataSource = self
        saveCardTable.tableFooterView = UIView(frame: .zero)
        saveCardTable.rowHeight = 74
        saveCardTable.register(SaveCardCell.self, forCellReuseIdentifier: "saveCard")
        
        raveCardClient.removesavedCardSuccess = { [weak self] in
            DispatchQueue.main.async {
               
                self?.saveCardTable.reloadData()
            }
        }
        
        raveCardClient.removesavedCardError = { message in
            
            showSnackBarWithMessage(msg: message ?? "An error occured deleting saved card")
        }
        setupConstraint()
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            saveCardTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             saveCardTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              saveCardTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               saveCardTable.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
    


}

extension SaveCardViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveCard") as! SaveCardCell
        let card =  self.savedCards?[indexPath.row]
        cell.maskCardLabel.text = card?.card?.maskedPan
        cell.brandImage.image = card?.card?.cardBrand?.lowercased() == .some("visa") ? UIImage(named: "rave_visa",in: Bundle.getResourcesBundle(), compatibleWith: nil) : UIImage(named: "rave_mastercard",in: Bundle.getResourcesBundle(), compatibleWith: nil)
        cell.contentContainer.layer.cornerRadius = 8
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let card =  self.savedCards?[indexPath.row]
       delegate?.cardSelected(card: card)
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let card =  self.savedCards?[indexPath.row]
        let deleteRequest = UIContextualAction(style: .normal, title: "Delete") { (action, view, complete) in
           self.raveCardClient.savedCardHash = card?.cardHash
           self.raveCardClient.savedCardMobileNumber = card?.mobileNumber
           self.raveCardClient.removeSavedCard()
            
            self.savedCards = self.savedCards?.filter({ (c) -> Bool in
                return c.cardHash! != card?.cardHash!
            })
            self.saveCardTable.reloadData()
        }
        deleteRequest.backgroundColor = UIColor(hex: "#FF4A4A")
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteRequest])
        return swipeAction
    }
    
    
}
