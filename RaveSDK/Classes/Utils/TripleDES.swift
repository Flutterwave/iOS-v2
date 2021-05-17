//
//  TripleDES.swift
//  flutterwave
//
//  Created by Johnson Ejezie on 07/12/2016.
//  Copyright © 2016 johnsonejezie. All rights reserved.
//

import Foundation

import CommonCrypto

public class TripleDES {
    static func encrypt(string:String, key:String) -> NSData? {
        
        let keyData: NSData! = (key as NSString).data(using: String.Encoding.utf8.rawValue) as! NSData
        let keyBytes         = keyData.bytes
        
        let data: NSData! = (string as NSString).data(using: String.Encoding.utf8.rawValue) as! NSData
        let dataLength    = UInt(data.length)
        let dataBytes     = data.bytes
        
        let cryptData    = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)!
        let cryptPointer = cryptData.mutableBytes
        let cryptLength  = size_t(cryptData.length)
        
        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionPKCS7Padding+kCCOptionECBMode)
        
        var numBytesEncrypted :Int = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  keyBytes, keyLength,
                                  nil,
                                  dataBytes, Int(dataLength),
                                  cryptPointer, cryptLength,
                                  &numBytesEncrypted)
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            let _: Int = numBytesEncrypted
            cryptData.length = Int(numBytesEncrypted)
            return cryptData
        } else {
            print("Error: \(cryptStatus)")
        }
        return nil
    }
}
