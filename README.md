<p align="center">
    <img title="Flutterwave" height="200" src="https://flutterwave.com/images/logo-colored.svg" width="50%"/>
</p>



# RaveSDK

[![CI Status](https://img.shields.io/travis/solejay/RaveSDK.svg?style=flat)](https://travis-ci.org/solejay/RaveSDK)
[![Version](https://img.shields.io/cocoapods/v/RaveSDK.svg?style=flat)](https://cocoapods.org/pods/RaveSDK)
[![License](https://img.shields.io/cocoapods/l/RaveSDK.svg?style=flat)](https://cocoapods.org/pods/RaveSDK)
[![Platform](https://img.shields.io/cocoapods/p/RaveSDK.svg?style=flat)](https://cocoapods.org/pods/RaveSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
To install the RaveSDK you need to have Cocoapods installed on you Mac. If you don't have it installed you can paste the following code snippet in your Terminal
```ruby
 sudo gem install cocoapods
```

## Installation

RaveSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RaveSDK'
```

## Usage

```swift
 import UIKit
 import RaveSDK

 class ViewController: UIViewController ,RavePayProtocol {
     func tranasctionSuccessful(flwRef: String?, responseData: [String : Any]?) {
         
     }

     func tranasctionFailed(flwRef: String?, responseData: [String : Any]?) {
     
     }


     @IBAction func showAction(_ sender: Any) {
         let config = RaveConfig.sharedConfig()
         config.country = "NG" // Country Code
         config.currencyCode = "NGN" // Currency
         config.email = "[customer@email.com]" // Customer's email
         config.isStaging = false // Toggle this for staging and live environment
         config.phoneNumber = "[xxxxxxxxx]" //Phone number
         config.transcationRef = "ref" // transaction ref
         config.firstName = "[firstname]" 
         config.lastName = "[lastname]" 
         config.meta = [["metaname":"sdk", "metavalue":"ios"]]
         
         config.publicKey = "[PUB-KEY]" //Public key
         config.encryptionKey = "[ENCRYPTION-KEY]" //Encryption key

         
         let controller = NewRavePayViewController()
         let nav = UINavigationController(rootViewController: controller)
         controller.amount = "[amount]" 
         controller.delegate = self
         self.present(nav, animated: true)
     }
}
```

## Author

developers@flutterwavego.com

## License

RaveSDK is available under the MIT license. See the LICENSE file for more info.
