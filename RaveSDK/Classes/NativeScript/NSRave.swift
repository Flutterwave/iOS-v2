import UIKit

@objcMembers
public class NSRaveConfig: UIViewController, RavePayProtocol {
    public var publicKey:String?
    public var encryptionKey:String?
    public var isStaging:Bool = true
    public var email:String?
    public var firstName:String?
    public var lastName:String?
    public var phoneNumber:String?
    public var transcationRef:String?
    public var country:String = "NG"
    public var currencyCode:String = "NGN"
    public var narration:String?
    public var amount:String?
    public var delegate: NSRaveDelegate?

    public func tranasctionSuccessful(flwRef: String?, responseData: [String : Any]?) {
        self.delegate?.onSuccess(flwRef ?? "", responseData ?? "")
    }

    public func tranasctionFailed(flwRef: String?, responseData: [String : Any]?) {
        self.delegate?.onError(flwRef ?? "", responseData ?? "")
    }

    public func initRave(view: UIViewController) -> NSRaveConfig {

        let config = RaveConfig.sharedConfig()
        config.country = self.country
        config.currencyCode = self.currencyCode
        config.email = self.email
        config.isStaging = self.isStaging
        config.phoneNumber = self.phoneNumber
        config.transcationRef = self.transcationRef
        config.firstName = self.firstName
        config.lastName = self.lastName
        config.meta = [["metaname":"sdk", "metavalue":"ios"]]

        config.publicKey = self.publicKey
        config.encryptionKey = self.encryptionKey

        let controller = NewRavePayViewController()
        let nav = UINavigationController(rootViewController: controller)
        controller.amount = self.amount
        controller.delegate = self

        view.present(nav, animated: true)

        return self
    }
}