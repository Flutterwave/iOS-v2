//
//  RaveConfig.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 14/08/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import Foundation
public enum SuggestedAuthModel{
    case PIN,AVS_VBVSECURECODE,VBVSECURECODE,GTB_OTP,NOAUTH_INTERNATIONAL,NONE
}
public enum AuthModel{
    case OTP,WEB
}
public class RaveConfig {
    public var publicKey:String?
    public var secretKey:String?
    public var isStaging:Bool = true
    public var email:String?
    public var firstName:String?
    public var lastName:String?
    public var phoneNumber:String?
    public var transcationRef:String?
    public var country:String = "NG"
    public var currencyCode:String = "NGN"
    public var narration:String?
    public var isPreAuth:Bool = false
    public var meta:[[String:String]]?
    public var subAccounts:[SubAccount]?
    public var whiteListedBanksOnly:[String]?

    public class func sharedConfig() -> RaveConfig {
        struct Static {
            static let kbManager = RaveConfig()
            
        }
        return Static.kbManager
    }
}
