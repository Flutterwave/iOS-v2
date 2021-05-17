//
//  RaveAccountClient.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 14/08/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import Foundation
import UIKit
class RaveAccountClient {
    public var amount:String?
    public var accountNumber:String?
    public var bankCode:String?
    public var phoneNumber:String?
    public var passcode:String?
    public var bvn:String?
    public var isInternetBanking:Bool = false
    public var blacklistedBankCodes:[String]?
    public var isUSBankAccount =  false
    
    typealias BanksHandler = (([Bank]?) -> Void)
    typealias ErrorHandler = ((String?,[String:Any]?) -> Void)
    typealias FeeSuccessHandler = ((String?,String?) -> Void)
    typealias SuccessHandler = ((String?,[String:Any]?) -> Void)
    public var banks: BanksHandler?
    public var error:ErrorHandler?
    public var validateError:ErrorHandler?
    public var feeSuccess:FeeSuccessHandler?
    public var chargeSuccess: SuccessHandler?
    typealias OTPAuthHandler = ((String,String) -> Void)
    typealias WebAuthHandler = ((String,String) -> Void)
     typealias GBPOTPAuthHandler = ((String,String,String) -> Void)
    public var chargeOTPAuth: OTPAuthHandler?
    public var redoChargeOTPAuth: OTPAuthHandler?
     public var chargeGBPOTPAuth: GBPOTPAuthHandler?
    public var chargeWebAuth: WebAuthHandler?
    public var otp:String?
    public var transactionReference:String?
    var txRef:String?
    var chargeAmount:String?
    //MARK: Fee
    public func getFee(){
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
    
    //MARK: Bank List
    public func getBanks(){
        var banks:[Bank]? = []
        RavePayService.getBanks(resultCallback: { (_banks) in
            DispatchQueue.main.async {
                var _thebanks:[Bank]? = _banks
                if let count = self.blacklistedBankCodes?.count{
                    if count > 0 {
                        self.blacklistedBankCodes?.forEach({ (code) in
                            _thebanks = _thebanks?.filter({ (bank) -> Bool in
                                return  bank.bankCode! != code
                            })
                        })
                        banks = _thebanks
                        banks = banks?.sorted(by: { (first, second) -> Bool in
                            return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                        })
                        self.banks?(banks)
                    }else{
                        banks = _banks?.sorted(by: { (first, second) -> Bool in
                            return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                        })
                        self.banks?(banks)
                    }
                }else{
                    banks = _banks?.sorted(by: { (first, second) -> Bool in
                        return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                    })
                    self.banks?(banks)
                }
            }
            
        }) { (err) in
            print(err)
        }
        
    }
    //MARK: Charge
    public func chargeAccount(){
        if let pubkey = RaveConfig.sharedConfig().publicKey{
            let isInternetBanking = (self.isInternetBanking) == true ? 1 : 0
            var country :String = ""
            switch RaveConfig.sharedConfig().currencyCode {
                       case "KES","TZS","GHS","KES","ZAR":
                           country = RaveConfig.sharedConfig().country
                       default:
                           country = "NG"
                       }
            guard let _ = amount else {
                fatalError("Amount is missing")
            }
//            guard let _ = accountNumber else {
//                fatalError("Account Number is missing")
//            }
//            guard let _ = bankCode else {
//                fatalError("Bank Code is missing")
//            }
            guard let _ = phoneNumber else {
                fatalError("Mobile Number is missing")
            }
            guard let _ = RaveConfig.sharedConfig().email else {
                fatalError("Email address is missing")
            }
            guard let _ = RaveConfig.sharedConfig().transcationRef else {
                fatalError("transactionRef is missing")
            }
            var param:[String:Any] = [
                "PBFPubKey": pubkey,
                "amount": amount!,
                "email": RaveConfig.sharedConfig().email!,
                "payment_type":"account",
                "phonenumber":phoneNumber!,
                "firstname":RaveConfig.sharedConfig().firstName ?? "",
                "lastname": RaveConfig.sharedConfig().lastName ?? "",
                "currency": RaveConfig.sharedConfig().currencyCode,
                "country":country,
                "IP": getIFAddresses().first!,
                "txRef":  RaveConfig.sharedConfig().transcationRef!,
                "device_fingerprint": (UIDevice.current.identifierForVendor?.uuidString)!,
                "redirect_url": "https://webhook.site/finish"
            ]
            if let accountNumber = self.accountNumber{
                param.merge(["accountnumber":accountNumber])
            }
            if let code = self.bankCode{
                param.merge(["accountbank":code])
            }
            
            if RaveConfig.sharedConfig().isPreAuth{
                param.merge(["charge_type":"preauth"])
            }
            if let passcode = self.passcode{
                param.merge(["passcode":passcode])
            }
            if let bvn = self.bvn{
                param.merge(["bvn":bvn])
            }
            if(isInternetBanking == 1){
                param.merge(["is_internet_banking":"\(isInternetBanking)"])
            }
            if let narrate = RaveConfig.sharedConfig().narration{
                param.merge(["narration":narrate])
            }
            if let meta = RaveConfig.sharedConfig().meta{
                param.merge(["meta":meta])
            }
            if isUSBankAccount{
             param.merge(["is_us_bank_charge" : "\(isUSBankAccount)"])
            }
            if RaveConfig.sharedConfig().currencyCode == "GBP"{
                param.merge(["is_uk_bank_charge2" :1, "accountname":accountNumber])
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
                        if RaveConfig.sharedConfig().currencyCode == "GBP"{
                            if let chargeResponse = result?["response_code"] as? String{
                                switch chargeResponse {
                                case "00":
                                    let data = result?["data"] as? Dictionary<String,AnyObject>
                                    if let flwTransactionRef = data?["flw_reference"] as? String{
                                       self.chargeSuccess?(flwTransactionRef,result)
                                    }
                                case "02":
                                        let data = result?["data"] as? Dictionary<String,AnyObject>
                                        let paymentCode = data?["payment_code"] as? String
                                        if let flwTransactionRef = data?["flw_reference"] as? String{
                                            self.chargeGBPOTPAuth?(flwTransactionRef,paymentCode ?? "","")
                                            self.txRef = flwTransactionRef
                                            //self.txRef = data?["transaction_reference"] as? String
                                            //let txRef = data?["transaction_reference"] as? String
                                           // self.queryTransaction(txRef: flwTransactionRef)
                                        }
                                default:
                                    break
                                }
                            }
                        }else{
                        if let chargeResponse = result?["chargeResponseCode"] as? String{
                            switch chargeResponse{
                            case "00":
                                
                                if let flwTransactionRef = result?["flwRef"] as? String{
                                   self.chargeSuccess?(flwTransactionRef,result)
                                }
                             
                            case "02":
                                let flwTransactionRef = result?["flwRef"] as? String
                                //chargeResponseMessage
                                var _instruction:String? = result?["chargeResponseMessage"] as? String
                                if let instruction = result?["validateInstruction"] as? String{
                                    _instruction = instruction
                                }else{
                                    if let instruction = result?["validateInstructions"] as? [String:AnyObject]{
                                        if let  _inst =  instruction["instruction"] as? String{
                                            if _inst != ""{
                                                _instruction = _inst
                                            }
                                        }
                                    }
                                }
                                    if let authURL = result?["authurl"] as? String, authURL != "NO-URL", authURL != "N/A"{
                                        self.chargeWebAuth?(flwTransactionRef!,authURL)
                                    }else{
                                        if let flwRef = flwTransactionRef{
                                            self.chargeOTPAuth?(flwRef, _instruction ?? "Pending OTP Validation")
                                        }
                                    }
                            default:
                                break
                            }
                         }
                        }
                    }else{
                        if let message = res?["message"] as? String{
                            
                            self.error?(message, nil)
                            
                        }
                    }
                }
                
                
            }, errorCallback: { (err) in
                
                self.error?(err, nil)
            })
            
        }
    }
    
    //MARK: Validate OTP
    public func validateAccountOTP(){
        guard let ref = self.transactionReference, let _otp = otp else {
            self.error?("Transaction Reference  or OTP is not set",nil)
            return
        }
        let reqbody = [
            "PBFPubKey": RaveConfig.sharedConfig().publicKey!,
            "transactionreference": ref,
            "otp": _otp
        ]
        RavePayService.validateAccountOTP(reqbody, resultCallback: { (result) in
            if let res =  result{
                if let data = res ["data"] as? [String:AnyObject]{
                    if let flwRef = data["flwRef"] as? String{
                        if let chargeResponse = data["chargeResponseCode"] as? String{
                            if chargeResponse == "02" {
                                if let dataStatus = data["status"] as? String{
                                    if (dataStatus.containsIgnoringCase(find: "failed")){
                                        if let message = data["acctvalrespmsg"] as? String{
                                            self.validateError?(message, data)
                                        }
                                    }else{
                                            let message = data["chargeResponseMessage"] as? String
                                            self.redoChargeOTPAuth?(flwRef,message ?? "Pending OTP Validation")
                                    }
                                }else{
                                        let message = data["chargeResponseMessage"] as? String
                                        self.redoChargeOTPAuth?(flwRef,message ?? "Pending OTP Validation")
                                }
                            }else{
                                self.chargeSuccess?(flwRef,result)

                            }
                        }
                        
                    }
                }else{
                        let message = res ["message"] as? String
                        self.validateError?(message, nil)
                }
            }
        }) { (err) in
            if (err.containsIgnoringCase(find: "serialize") || err.containsIgnoringCase(find: "JSON")){
                self.validateError?("Request Timed Out",nil)
            }else{
                self.validateError?(err,nil)
            }
        }
    }
    
    
  public  func queryTransaction(txRef:String?){
           if let secret = RaveConfig.sharedConfig().publicKey ,let  ref = txRef{
               let param = ["PBFPubKey":secret,"flw_ref":ref]
               RavePayService.mpesaQueryTransaction(param, resultCallback: { (result) in
                   if let  status = result?["status"] as? String{
                       if (status == "success"){
                           if let data = result?["data"] as? [String:AnyObject]{
                               let flwRef = data["flwref"] as? String
                               if let chargeCode = data["chargeResponseCode"] as?  String{
                                   switch chargeCode{
                                   case "00":
                                       self.chargeSuccess?(flwRef,result)
                                   
                                   default:
                                       self.queryTransaction(txRef: ref)
                                   }
                               }else{
                                   self.queryTransaction(txRef: ref)
                               }
                           }
                       }else{
                               self.error?("Something went wrong please try again.",nil)
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
