//
//  Constants.swift
//  RaveMobile
//
//  Created by Segun Solaja on 10/5/15.
//  Copyright © 2015 Segun Solaja. All rights reserved.
//

import UIKit
import Alamofire

class RaveConstants: NSObject {

    class func baseURL () -> String{
        //return "https://ravesandbox.azurewebsites.net"
        return "https://api.ravepay.co"
    }
    class func liveBaseURL() -> String{
       // return "https://raveapi.azurewebsites.net"
        return "https://api.ravepay.co"
       
    }
    class func v2liveBaseURL() -> String{
        return "https://api.ravepay.co"
        
    }
   
    static let bankStyle = [
                     (code:"101",color:"#ffffff",image:"rave_providus2"),
                     (code:"232",color:"#ad1620",image:"rave_sterling2"),
                     (code:"057",color:"#ed3237",image:"rave_zenith2"),
                     (code:"601",color:"#ffffff",image:"rave_fsdh"),
                     (code:"076",color:"#ffffff",image:"rave_polaris"),
                     (code:"214",color:"#5c3092",image:"rave_fcmb"),
                     (code:"050",color:"#ffffff",image:"rave_ecobank"),
                     (code:"011",color:"#143f89",image:"rave_firstbank"),
                     (code:"058",color:"#ffffff",image:"rave_gtb"),
                     (code:"215",color:"#FFFFFF",image:"rave_unity"),
                     (code:"033",color:"#FFFFFF",image:"rave_uba")]
    
    static let ghsMobileNetworks = [("MTN","Please Dial *170#, click on Pay and wait for instructions on the next screen",
                                     """
                                        Complete payment process
                                        1. Dial *170#
                                        2. Choose option: 7) Wallet
                                        3. Choose option: 3) My Approvals
                                        4. Enter your MOMO pin to retrieve your pending approval list
                                        5. Choose a pending transaction
                                        6. Choose option 1 to approve
                                        7. Tap button to continue)
                                        """),
                                    ("TIGO","Please Dial *501*5#, click on Pay and wait for instructions on the next screen",
                                     """
                                        Complete payment process
                                        1. Dial *501*5# to approve your transaction.
                                        2. Select the transaction to approve and click on send.
                                        3. Select YES to confirm your payment.
                                        """),
                                    ("VODAFONE","Please Dial *110# and follow the instructions to generate your transaction voucher.",
                                     """
                                        Complete payment process
                                        1. Dial  *110# to generate your transaction voucher.
                                        2. Select option) 6 to generate the voucher.
                                        3. Enter your PIN in next prompt.
                                        4. Input the voucher generated in the payment modal
                                        """),
                                    ("AIRTEL","","")]
    
    static let zambianNetworks = ["AIRTEL","MTN","ZAMTEL"]
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
   
 
    class func relativeURL()->Dictionary<String,String>{
        return [
            "CHARGE_CARD" :"/flwv3-pug/getpaidx/api/charge",
            "VALIDATE_CARD_OTP" :"/flwv3-pug/getpaidx/api/validatecharge",
            "VALIDATE_ACCOUNT_OTP":"/flwv3-pug/getpaidx/api/validate",
            "BANK_LIST":"/flwv3-pug/getpaidx/api/flwpbf-banks.js?json=1",
            "CHARGE_WITH_TOKEN":"/flwv3-pug/getpaidx/api/tokenized/charge",
            "QUERY_TRANSACTION":"/flwv3-pug/getpaidx/api/v2/verify",
            "MPESA_QUERY_TRANSACTION":"/flwv3-pug/getpaidx/api/verify/mpesa",
            "FEE":"/flwv3-pug/getpaidx/api/fee",
            "SAVE_CARD_LOOKUP":"/v2/gpx/users/lookup",
            "SEND_SAVEDCARD_OTP":"/v2/gpx/users/send_otp",
            "REMOVE_SAVEDCARD":"/v2/gpx/users/remove"
        ]
    }
    
   
    class func headerConstants(_ headerParam:Dictionary<String,String>)->Dictionary<String,String> {
     
       /* var defaultsDict:Dictionary<String,String>  =  [
            "apikey":apiKey,
            "secret": apiSecret]*/
      
        
//        if(headerParam.isEmpty){
//            return defaultsDict
//        }else{
//            defaultsDict.merge(headerParam)
//            return defaultsDict
//        }
        
       return  headerParam

    }

    

}
