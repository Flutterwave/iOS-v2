//
//  URLHelper.swift
//  RaveMobile
//
//  Created by Segun Solaja on 10/5/15.
//  Copyright © 2015 Segun Solaja. All rights reserved.
//

import UIKit

class RaveURLHelper: NSObject {
    static let isStaging = RaveConfig.sharedConfig().isStaging
    class func getURL(_ URLKey:String) ->String{
        return self.getURL(URLKey, withURLParam: [:])
    }
    
    
    class func getURL(_ URLKey:String ,withURLParam:Dictionary<String,String>) -> String{
        if (!withURLParam.isEmpty){
            var str:String!
           str =  RaveConstants.relativeURL()[URLKey]!
            for (key,value) in withURLParam{     
               str = str.replacingOccurrences(of: ":" + key, with: value)
            }
            return (isStaging == false ? RaveConstants.liveBaseURL(): RaveConstants.baseURL()) + str!
            
        }else{
            print((isStaging == false ? RaveConstants.liveBaseURL(): RaveConstants.baseURL()) + RaveConstants.relativeURL()[URLKey]!)
            return (isStaging == false ? RaveConstants.liveBaseURL(): RaveConstants.baseURL()) + RaveConstants.relativeURL()[URLKey]!
        }
    }
    
    class func getV2URL(_ URLKey:String ,withURLParam:Dictionary<String,String>) -> String{
        if (!withURLParam.isEmpty){
            var str:String!
            str =  RaveConstants.relativeURL()[URLKey]!
            for (key,value) in withURLParam{
                str = str.replacingOccurrences(of: ":" + key, with: value)
            }
            return (isStaging == false ? RaveConstants.v2liveBaseURL(): RaveConstants.baseURL()) + str!
            
        }else{
            print((isStaging == false ? RaveConstants.v2liveBaseURL(): RaveConstants.baseURL()) + RaveConstants.relativeURL()[URLKey]!)
            return (isStaging == false ? RaveConstants.v2liveBaseURL(): RaveConstants.baseURL()) + RaveConstants.relativeURL()[URLKey]!
        }
    }
    

}
