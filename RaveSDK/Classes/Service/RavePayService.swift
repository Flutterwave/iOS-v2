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
        
		let req: URLConvertible = RaveURLHelper.getV2URL("QUERY_TRANSACTION",withURLParam: [:])
		
		AF.request(req, method: .post, parameters: bodyParam).responseJSON { res in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback( error.localizedDescription)
			}
		}
        
        
    }

    class func mpesaQueryTransaction(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		let req: URLConvertible = RaveURLHelper.getURL("MPESA_QUERY_TRANSACTION",withURLParam: [:])

        AF.request(req,method: .post, parameters: bodyParam).responseJSON {
            (res) -> Void in

			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback( error.localizedDescription)
			}
        }


    }
    class func getSavedCards(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:SavedCardResponse) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("SAVE_CARD_LOOKUP")
		
		AF.request(req,method: .post, parameters: bodyParam).responseDecodable(of: SavedCardResponse.self) {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				print(res.request?.urlRequest ?? "")
				resultCallback(value)
				
			case .failure(let error):
				print(error)
				errorCallback( error.localizedDescription)
			}
		}
    }
    class func getFee(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
       // print(bodyParam.description)
		let req: URLConvertible = RaveURLHelper.getURL("FEE")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback( error.localizedDescription)
			}
		}
    }
    class func removeSavedCard(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("REMOVE_SAVEDCARD")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback(error.localizedDescription)
			}
		}
    }

    class func sendOTP(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ result:String) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("SEND_SAVEDCARD_OTP")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					if let status = json["status"] as? String{
						if status == "success"{
							resultCallback("Enter the OTP sent to your mobile phone and email address to continue")
						}
					}else{
						let message = json["message"] as? String
						errorCallback(message ?? "An error occured")
					}
				}
			case .failure(let error):
				print(error)
				errorCallback(error.localizedDescription)
			}
		}
    }
	
    class func getBanks(resultCallback:@escaping (_ result:[Bank]?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("BANK_LIST")
		
		AF.request(req,method: .get, parameters: nil).responseDecodable(of: [Bank].self) {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				print(res.request?.urlRequest ?? "")
				resultCallback(value)
				
			case .failure(let error):
				print(error)
				errorCallback( error.localizedDescription)
			}
		}
    }
    class func charge(_ bodyParam:Dictionary<String,Any>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("CHARGE_CARD")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback(error.localizedDescription)
			}
		}

     }
    class func chargeWithToken(_ bodyParam:Dictionary<String,Any>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("CHARGE_WITH_TOKEN")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback(error.localizedDescription)
			}
		}
    }

    class func validateCardOTP(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
		
		let req: URLConvertible = RaveURLHelper.getURL("VALIDATE_CARD_OTP")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback(error.localizedDescription)
			}
		}
    }
    class func validateAccountOTP(_ bodyParam:Dictionary<String,String>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){

		let req: URLConvertible = RaveURLHelper.getURL("VALIDATE_ACCOUNT_OTP")
		
		AF.request(req,method: .post, parameters: bodyParam).responseJSON {
			(res) -> Void in
			
			switch res.result {
			case .success(let value):
				if let json = value as? Dictionary<String,AnyObject> {
					print(res.request?.urlRequest ?? "")
					print(json)
					resultCallback(json)
				}
			case .failure(let error):
				print(error)
				errorCallback(error.localizedDescription)
			}
		}
    }
}
