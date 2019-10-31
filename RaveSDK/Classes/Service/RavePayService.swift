//
//  RavePayService.swift
//  RaveMobile
//
//  Created by Olusegun Solaja on 19/07/2017.
//  Copyright © 2017 Olusegun Solaja. All rights reserved.
//

import UIKit
import Alamofire

class RavePayService: NSObject {
    class func queryTransaction(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getV2URL("QUERY_TRANSACTION",withURLParam: [:]),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as? Dictionary<String,AnyObject>
                 print(res.request?.urlRequest ?? "")
                 print(result ?? "")
              //  let data = result?["data"] as? Dictionary<String,AnyObject>
               
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    class func mpesaQueryTransaction(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("MPESA_QUERY_TRANSACTION",withURLParam: [:]),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as? Dictionary<String,AnyObject>
                 print(res.request?.urlRequest ?? "")
                 print(result ?? "")
              //  let data = result?["data"] as? Dictionary<String,AnyObject>
               
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    class func getSavedCards(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:SavedCardResponse) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("SAVE_CARD_LOOKUP"),method: .post, parameters: bodyParam).responseData {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let decoder = JSONDecoder()
                if let data = res.data{
                    if let res = try? decoder.decode(SavedCardResponse.self, from:data){
                        resultCallback(res)
                    }else{
                        errorCallback("An Error has occured please try again")
                    }
                }
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    class func getFee(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
       // print(bodyParam.description)
        Alamofire.request(RaveURLHelper.getURL("FEE"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as? Dictionary<String,AnyObject>
                //  let data = result?["data"] as? Dictionary<String,AnyObject>
                
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    class func removeSavedCard(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("REMOVE_SAVEDCARD"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as? Dictionary<String,AnyObject>
                //  let data = result?["data"] as? Dictionary<String,AnyObject>
                
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    
    class func sendOTP(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:String) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("SEND_SAVEDCARD_OTP"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as? Dictionary<String,AnyObject>
                if let status = result?["status"] as? String{
                    if status == "success"{
                     resultCallback("Enter the OTP sent to your mobile phone and email address to continue")
                    }
                }else{
                    let message = result?["message"] as? String
                    errorCallback(message ?? "An error occured")
                }
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    class func getBanks(resultCallback:@escaping (_ result:[Bank]?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("BANK_LIST"),method: .get, parameters: nil).responseData {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let decoder = JSONDecoder()
                if let data = res.data{
                    if let res = try? decoder.decode([Bank].self, from:data){
                            resultCallback(res)
                    }else{
                        errorCallback("An Error has occured please try again")
                    }
                }
                
//                let result = res.result.value as! [Dictionary<String,AnyObject>]
//
//                let banks = result.map({ (item) -> Bank in
//                    BankConverter.convert(item)
//                })
              //  resultCallback(banks)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    class func charge(_ bodyParam:Dictionary<String,Any>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("CHARGE_CARD"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
                if(res.result.isSuccess){
                    let result = res.result.value as! Dictionary<String,AnyObject>
                    print(result)
                    
                       // let data = result["data"] as? Dictionary<String,AnyObject>
                        resultCallback(result)
                    
                    
                }else{
                    errorCallback( res.result.error!.localizedDescription)
                }
            }
        
        
     }
    class func chargeWithToken(_ bodyParam:Dictionary<String,Any>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("CHARGE_WITH_TOKEN"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as! Dictionary<String,AnyObject>
                print(result)
                
                // let data = result["data"] as? Dictionary<String,AnyObject>
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
    
    class func validateCardOTP(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("VALIDATE_CARD_OTP"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as! Dictionary<String,AnyObject>
                //print(result)
                
              //  let data = result["data"] as? Dictionary<String,AnyObject>
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
    }
    class func validateAccountOTP(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        Alamofire.request(RaveURLHelper.getURL("VALIDATE_ACCOUNT_OTP"),method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in
            
            if(res.result.isSuccess){
                let result = res.result.value as! Dictionary<String,AnyObject>
                //print(result)
                
                //let data = result["data"] as? Dictionary<String,AnyObject>
                resultCallback(result)
                
                
            }else{
                errorCallback( res.result.error!.localizedDescription)
            }
        }
        
        
    }
}
