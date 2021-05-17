//
//  RaveMobileMoney.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 14/08/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//


import Foundation
import UIKit

enum MobileMoneyType{
    case ghana
    case uganda
    case rwanda
    case zambia
    case franco
}

class RaveMobileMoneyClient {
    public var amount:String?
    public var phoneNumber:String?
    public var email:String? = ""
    public var voucher:String?
    public var network:String?
    public var selectedMobileNetwork:String?
    typealias FeeSuccessHandler = ((String?,String?) -> Void)
    typealias PendingHandler = ((String?,String?) -> Void)
    typealias ErrorHandler = ((String?,[String:Any]?) -> Void)
    typealias SuccessHandler = ((String?,[String:Any]?) -> Void)
    typealias WebAuthHandler = ((String,String) -> Void)
    public var error:ErrorHandler?
    public var feeSuccess:FeeSuccessHandler?
    public var transactionReference:String?
    public var chargeSuccess: SuccessHandler?
    public var chargePending: PendingHandler?
    public var chargeWebAuth: WebAuthHandler?
    public var mobileMoneyType:MobileMoneyType = .ghana
    
    //MARK: Get transaction Fee
    public func getFee(){
        if RaveConfig.sharedConfig().currencyCode == "GHS" || RaveConfig.sharedConfig().currencyCode == "UGX"
            || RaveConfig.sharedConfig().currencyCode == "RWF" || RaveConfig.sharedConfig().currencyCode == "XAF"
            || RaveConfig.sharedConfig().currencyCode == "XOF" || RaveConfig.sharedConfig().currencyCode == "ZMW"{
            if let pubkey = RaveConfig.sharedConfig().publicKey{
                let param = [
                    "PBFPubKey": pubkey,
                    "amount": amount!,
                    "currency": RaveConfig.sharedConfig().currencyCode,
                    "ptype": "2"]
                RavePayService.getFee(param, resultCallback: { (result) in
                    let data = result?["data"] as? [String:AnyObject]
                    if let _fee =  data?["fee"] as? Double{
                        let fee = "\(_fee)"
                        let chargeAmount = data?["charge_amount"] as? String
                        self.feeSuccess?(fee,chargeAmount)
                    }else{
                        if let err = result?["message"] as? String{
                            self.error?(err,nil)
                        }
                    }
                }, errorCallback: { (err) in
                    
                    self.error?(err,nil)
                })
            }else{
                self.error?("Public Key is not specified",nil)
            }
        }
    }
    
    //MARK: Charge
    public func chargeMobileMoney(_ type:MobileMoneyType = .ghana){
        var country :String = ""
        switch RaveConfig.sharedConfig().currencyCode {
        case "KES","TZS","GHS","KES","ZAR":
            country = RaveConfig.sharedConfig().country
        default:
            country = "NG"
        }
        if let pubkey = RaveConfig.sharedConfig().publicKey{
            var param:[String:Any] = [
                "PBFPubKey": pubkey,
                "amount": amount!,
                "email": email!,
                "phonenumber":phoneNumber ?? "",
                "currency": RaveConfig.sharedConfig().currencyCode,
                "firstname":RaveConfig.sharedConfig().firstName ?? "",
                "lastname": RaveConfig.sharedConfig().lastName ?? "",
                "country":country,
                "meta":"",
                "IP": getIFAddresses().first!,
                "txRef": transactionReference!,
                "orderRef": transactionReference!,
                "device_fingerprint": (UIDevice.current.identifierForVendor?.uuidString)!,
                "redirect_url": "https://webhook.site/finish"
            ]
            switch type{
            case .ghana :
                param.merge(["network": network ?? "","is_mobile_money_gh":"1","payment_type": "mobilemoneygh"])
            case .uganda :
                param.merge(["network": "UGX","is_mobile_money_ug":"1","payment_type": "mobilemoneyuganda"])
            case .rwanda :
                param.merge(["network": "RWF","is_mobile_money_gh":"1","payment_type": "mobilemoneygh"])
            case .zambia:
                param.merge(["network": network ?? "","is_mobile_money_ug":"1","payment_type": "mobilemoneyzambia"])
            case .franco:
                param.merge(["is_mobile_money_franco":"1","payment_type": "mobilemoneyfranco"])
            }
            if RaveConfig.sharedConfig().isPreAuth{
                param.merge(["charge_type":"preauth"])
            }
            if let subAccounts = RaveConfig.sharedConfig().subAccounts{
                let subAccountDict =  subAccounts.map { (subAccount) -> [String:String] in
                    var dict = ["id":subAccount.id]
                    if let ratio = subAccount.ratio{
                        dict.merge(["transaction_split_ratio":"\(ratio)"])
                    }
                    if let chargeType = subAccount.charge_type{
                        switch chargeType{
                        case .flat :
                            dict.merge(["transaction_charge_type":"flat"])
                            if let charge = subAccount.charge{
                                dict.merge(["transaction_charge":"\(charge)"])
                            }
                        case .percentage:
                            dict.merge(["transaction_charge_type":"percentage"])
                            if let charge = subAccount.charge{
                                dict.merge(["transaction_charge":"\((charge / 100))"])
                            }
                        }
                    }
                    
                    return dict
                }
                param.merge(["subaccounts":subAccountDict])
            }
            
            if let _voucher = self.voucher , _voucher != ""{
                param.merge(["voucher":_voucher])
            }
            let jsonString  = param.jsonStringify()
            let secret = RaveConfig.sharedConfig().encryptionKey!
            let data =  TripleDES.encrypt(string: jsonString, key:secret)
            let base64String = data?.base64EncodedString()
            
            let reqbody = [
                "PBFPubKey": pubkey,
                "client": base64String!, // Encrypted $data payload here.
                "alg": "3DES-24"
            ]
            RavePayService.charge(reqbody, resultCallback: { (res) in
                if let status = res?["status"] as? String{
                    if status == "success"{
                        let result = res?["data"] as? Dictionary<String,AnyObject>
                        if let code = result?["code"] as? String, code == "02"{
                            if let authURL = result?["link"] as? String {
                                self.chargeWebAuth?("",authURL)
                            }
                        }else{
                            let flwTransactionRef = result?["flwRef"] as? String
                            if let chargeResponse = result?["chargeResponseCode"] as? String{
                                switch chargeResponse{
                                case "00":
                                    self.chargeSuccess?(flwTransactionRef!,res)
                                    
                                case "02":
                                    if let authURL = result?["authurl"] as? String, authURL != "NO-URL", authURL != "N/A" {
                                        // Show Web View
                                        self.chargeWebAuth?(flwTransactionRef!,authURL)
                                        if let txRef = result?["flwRef"] as? String{
                                            self.queryMpesaTransaction(txRef: txRef)
                                        }
                                        
                                    }else{
                                        
                                        if let type =  result?["paymentType"] as? String,let currency = result?["currency"] as? String {
                                            print(type)
                                            if (type.containsIgnoringCase(find: "mpesa") || type.containsIgnoringCase(find: "mobilemoneygh") || type.containsIgnoringCase(find: "mobilemoneyzm") ||  currency.containsIgnoringCase(find: "UGX")) {
                                                if let status =  result?["status"] as? String{
                                                    if (status.containsIgnoringCase(find: "pending")){
                                                        
                                                        self.chargePending?("Transaction Processing","A push notification has been sent to your phone, please complete the transaction by entering your pin.\n Please do not close this page until transaction is completed")
                                                        if let txRef = result?["flwRef"] as? String{
                                                            self.queryMpesaTransaction(txRef: txRef)
                                                        }
                                                        
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                default:
                                    break
                                }
                            }
                        }
                    }else{
                        if let message = res?["message"] as? String{
                            print(message)
                            self.error?(message, nil)
                        }
                    }
                }
                
                
            }, errorCallback: { (err) in
                
                self.error?(err, nil)
            })
            
        }
    }
    
    //MARK: Requery transaction
    func queryMpesaTransaction(txRef:String?){
        if let secret = RaveConfig.sharedConfig().publicKey ,let  ref = txRef{
            let param = ["PBFPubKey":secret,"flw_ref":ref]
            print(param)
            RavePayService.mpesaQueryTransaction(param, resultCallback: { (result) in
                if let  status = result?["status"] as? String, let message = result?["message"]  as? String{
                    if (status == "success"){
                        if let data = result?["data"] as? [String:AnyObject]{
                            let flwRef = data["flwref"] as? String
                            if let chargeCode = data["chargeResponseCode"] as?  String{
                                switch chargeCode{
                                case "00":
                                    self.chargeSuccess?(flwRef,result)
                                    
                                default:
                                    self.queryMpesaTransaction(txRef: ref)
                                }
                            }else{
                                self.queryMpesaTransaction(txRef: ref)
                            }
                        }
                    }else{
                        self.error?(message,nil)
                    }
                }
            }, errorCallback: { (err) in
                
                if (err.containsIgnoringCase(find: "serialize") || err.containsIgnoringCase(find: "JSON")){
                    self.error?("Request Timed Out",nil)
                }else{
                    self.error?(err,nil)
                }
                
            })
        }
    }
    
    
}
