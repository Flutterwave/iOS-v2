//
//  Extension.swift
//  RaveMobile
//
//  Created by Olusegun Solaja on 18/07/2017.
//  Copyright © 2017 Olusegun Solaja. All rights reserved.
//

import UIKit
import CommonCrypto
//import ifaddrs

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

enum Style{
    case  success , error
    
}
func showSnackBarWithMessage(msg: String, style:Style = .success,autoComplete:Bool = false, completion:(()-> Void)? = nil){
    if autoComplete{
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion?()
        }
    }
    let message =  msg
    let snack = SnackBar.shared
    snack.message = message
    
    switch style{
    case .success:
        snack.statusColor = UIColor(hex: "#397A7F")
    case .error:
        snack.statusColor = UIColor(hex: "#9C4A47")
    }
    
    snack.show()
}

public enum SubAccountChargeType:String {
    case flat = "flat" , percentage = "percentage"
}
public class SubAccount{
    public let id:String
    public let ratio:Double?
    public let charge_type:SubAccountChargeType?
    public let charge:Double?
    
    public init(id:String , ratio:Double?, charge_type:SubAccountChargeType? ,charge:Double?) {
        self.id = id
        self.ratio = ratio
        self.charge_type = charge_type
        self.charge = charge
    }
}


func MD5(string: String) -> Data? {
    guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
    var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    
    _ = digestData.withUnsafeMutableBytes {digestBytes in
        messageData.withUnsafeBytes {messageBytes in
            CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
        }
    }
    
    return digestData
}


 func getEncryptionKey(_ secretKey:String)->String {
    let md5Data = MD5(string:secretKey)
    let md5Hex =  md5Data!.map { String(format: "%02hhx", $0) }.joined()
    
    var secretKeyHex = ""
    
    if secretKey.contains("FLWSECK-") {
        secretKeyHex = secretKey.replacingOccurrences(of: "FLWSECK-", with: "")
    }
//    if secretKey.contains("FLWSECK_TEST") {
//        secretKeyHex = secretKey.replacingOccurrences(of: "FLWSECK_TEST", with: "_TEST")
//    }
    if secretKey.contains("-X") {
        secretKeyHex = secretKeyHex.replacingOccurrences(of: "-X", with: "")
    }
    secretKeyHex = secretKey.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let index = secretKeyHex.index(secretKeyHex.startIndex, offsetBy: 12)
    let first12 = secretKeyHex.substring(to: index)
    
    let last12 = md5Hex.substring(from:md5Hex.index(md5Hex.endIndex, offsetBy: -12))
    return first12 + last12
    
}

func getIFAddresses() -> [String] {
    return["127.0.0.1"]
}

let themeColor:UIColor = UIColor(hex: "#382E4B")
let secondaryThemeColor:UIColor = UIColor(hex: "#E1E2E2")

func styleTextField(_ textField:UITextField, leftView:UIView? = nil){
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor(hex: "#E1E2E2").cgColor
    textField.layer.cornerRadius = textField.frame.height / 2
    //textField.layer.cornerRadius = 4
    if let v = leftView{
        textField.leftView = v
        textField.leftViewMode = .always
    }else{
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        textField.leftViewMode = .always
    }
}
extension Bundle {
   static func getResourcesBundle() -> Bundle? {
    let bundle = Bundle(for:NewRavePayViewController.self)
      guard let resourcesBundleUrl = bundle.resourceURL?.appendingPathComponent("RaveSDK.bundle") else {
         return nil
      }
      return Bundle(url: resourcesBundleUrl)
   }
}


extension String{
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    func getLocale(code:String) -> Locale{
		switch code {
		case "NGN":
			return Locale(identifier: "ig_Ng")
		case "USD":
			return Locale(identifier: "en_US")
		case "GBP":
			return Locale(identifier: "en_GB")
		case "KES":
			return Locale(identifier: "kam_KE")
		case "GHS":
			return Locale(identifier: "ak_GH")
		case "ZAR":
			return Locale(identifier: "en_ZA")
		case "UGX":
			return Locale(identifier: "nyn_UG")
		default:
			let locales: [String] = NSLocale.availableLocaleIdentifiers
			let loc = locales.map { (item) -> Locale in
				return Locale(identifier: item)
			}
			
			let current = loc.filter { (item) -> Bool in
				if let it = item.currencyCode{
					return it == code
				}else{
					return false
				}
			}.first
			return current ?? Locale.current
			
		}
    }
	func toRaveCurrency(_ withFraction:Int = 0, locale:Locale = Locale.current) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
		formatter.minimumFractionDigits = withFraction
        formatter.maximumFractionDigits = withFraction
		formatter.generatesDecimalNumbers = true
        formatter.locale = locale
        if self == ""{
            return formatter.string(from: NSNumber(value: 0))!
        }else{
            let val = (self as NSString).doubleValue
            return formatter.string(from: NSNumber(value: val))!
        }
    }
   /* func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }*/
    func index(of target: String) -> Int? {
            if let range = self.range(of: target) {
                return self.distance(from: startIndex, to: range.lowerBound)
            } else {
                return nil
            }
    }
        
    func lastIndex(of target: String) -> Int? {
            if let range = self.range(of: target, options: .backwards) {
                return self.distance(from: startIndex, to: range.lowerBound)
            } else {
                return nil
            }
    }
    func toCountryCurrency(code:String, fraction:Int = 2) -> String{
        var str:String = ""
        str = self.toRaveCurrency(fraction, locale: getLocale(code: code))
        return str
    }
    
}

public extension Dictionary{
    func jsonStringify()-> String {
        var str = ""
            do
            {
                let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                {
                     str = string as String
                }
            }
            catch
            {
            }
        
        return str
    }
    
    mutating func merge<K, V>(_ dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}
extension UIView {
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }

        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }

        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }

        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func centerInViewX(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?,padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {return}
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    func centerInViewY(leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?,padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {return}
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        if let leading = leading {
            leading.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX:NSLayoutXAxisAnchor? = nil, centerY:NSLayoutYAxisAnchor? = nil) -> AnchoredConstraints  {
        translatesAutoresizingMaskIntoConstraints = false

        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()

        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }

        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }

        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        return anchoredConstraints
    }
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func dropShadow() {

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 1


        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath

        // self.layer.shouldRasterize = true
    }

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        let layer = self.layer
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath.init(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath


        let backgroundCGColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }

    func removeShadow(){
        self.layer.shadowOpacity = 0
    }

    class func getAllSubviews<T: UIView>(view: UIView) -> [T] {
        return view.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(view: subView) as [T]
            if let view = subView as? T {
                result.append(view)
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] {
        return UIView.getAllSubviews(view: self) as [T]
    }


}
public extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex

        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            hex         = hex.substring(from: index)
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

