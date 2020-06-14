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


    @IBAction func showAction(_ sender: Any) {
        let config = RaveConfig.sharedConfig()
        config.country = "NG" // Country Code
        config.currencyCode = "NGN" // Currency
        config.email = "test@email.com"
        config.isStaging = true // Toggle this for staging and live environment
        config.phoneNumber = "08012345678" //Phone number
        config.transcationRef = "ref" // transaction ref
        config.firstName = "TEST" // first name
        config.lastName = "TEST" //lastname
        config.meta = [["metaname":"sdk", "metavalue":"ios"]]
        
        config.publicKey = "[PUB_KEY]" //Public key
        config.encryptionKey = "[ENCRYPTION_KEY]" //Encryption key

        
        let controller = NewRavePayViewController()
        let nav = UINavigationController(rootViewController: controller)
        controller.amount = "[AMOUNT]" // Amount
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

