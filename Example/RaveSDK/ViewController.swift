//
//  ViewController.swift
//  RaveSDK
//
//  Created by solejay on 09/27/2019.
//  Copyright (c) 2019 solejay. All rights reserved.
//

import UIKit
import RaveSDK

class ViewController: UIViewController ,RavePayProtocol {
    func tranasctionSuccessful(flwRef: String?, responseData: [String : Any]?) {
        print(responseData?.description ?? "Nothing here")
        
    }
    
    func tranasctionFailed(flwRef: String?, responseData: [String : Any]?) {
        print(responseData?.description ?? "Nothing here")
    }
    
    func onDismiss() {
        print("View controller was dimissed ")
    }
    
    @objc func showAction(){

        let config = RaveConfig.sharedConfig()
        config.paymentOptionsToExclude = []
        config.currencyCode = "NGN" // This is the specified currency to charge in.
        config.email = "[USER'S EMAIL]" // This is the email address of the customer
        config.isStaging = true // Toggle this for staging and live environment
        config.phoneNumber = "[USER'S PHONE_NUMBER]" //Phone number
        config.transcationRef = "[TRANSACTION REF]" // This is a unique reference, unique to the particular transaction being carried out. It is generated when it is not provided by the merchant for every transaction.
        config.firstName = "[USER'S FIRST NAME]" // This is the customers first name.
        config.lastName = "[USER'S SECOND NAME]" //This is the customers last name.
        config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information
        config.narration = "simplifying payments for endless possibilities"
        config.publicKey = "[PUB_KEY]" //Public key
        config.encryptionKey = "[ENCRYPTION_KEY]" //Encryption key
        config.isPreAuth = false  // This should be set to true for preauthoize card transactions
        let controller = NewRavePayViewController()
        let nav = UINavigationController(rootViewController: controller)
        controller.amount = "[AMOUNT]" // This is the amount to be charged.
        controller.delegate = self
        self.present(nav, animated: true)

    }
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

