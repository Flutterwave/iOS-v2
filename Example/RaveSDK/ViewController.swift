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
        config.country = "GH"
        config.currencyCode = "GHS"
        //        config.country = "ZA"
        //        config.currencyCode = "ZAR"
        config.email = "test@mailinator.com"
        config.isStaging = true
        config.phoneNumber = "08012345678"
        config.transcationRef = "ref"
        config.firstName = "Solejay"
        config.lastName = "baba"
        config.meta = [["metaname":"sdk", "metavalue":"ios"]]
        //config.whiteListedBanksOnly = ["011","058"]
        
        config.publicKey = "FLWPUBK-843da32837a606175e671012f5149d16-X"
        config.secretKey = "FLWSECK-3f908c1944683538e11845641952e3ff-X"

        
        let controller = NewRavePayViewController()
        let nav = UINavigationController(rootViewController: controller)
        controller.amount = "200"
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

