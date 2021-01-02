//
//  NSRaveDelegate.swift
//  RaveSDK
//
//  Created by Mohammed Bashiru on 02/01/2021.
//

@objc public protocol NSRaveDelegate {
    func onSuccess(_ data: Any, _ response: Any)
    func onError(_ data: Any, _ response: Any)
}
