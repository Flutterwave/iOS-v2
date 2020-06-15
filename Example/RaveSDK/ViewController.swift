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
        config.currencyCode = "ZMW" // Currency
        config.email = "test@email.com"
        config.isStaging = false // Toggle this for staging and live environment
        config.phoneNumber = "260967101211" //Phone number
        config.transcationRef = "ref" // transaction ref
        config.firstName = "TEST" // first name
        config.lastName = "TEST" //lastname
        config.meta = [["metaname":"sdk", "metavalue":"ios"]]
        
        config.publicKey = "FLWPUBK-1b8e026a1bd9adef61ae05ead9075ac3-X" //Public key
        config.encryptionKey = "db608b47440adbd4b9da53b3" //Encryption key

        
        let controller = NewRavePayViewController()
        let nav = UINavigationController(rootViewController: controller)
        controller.amount = "5" // Amount
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

