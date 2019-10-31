//
//  RavePayViewController.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 14/08/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit
import   UIKit.UILabel



enum OTPType {
    case card, bank, savedCard
}


public class RavePayViewController: UITableViewController {
    @IBOutlet var saveCardContainer: UIView!
    @IBOutlet weak var useAnotherCardButton: UIButton!
    @IBOutlet weak var rememberCardText: UILabel!
    @IBOutlet weak var rememberCardCheck: UIButton!
    
    @IBOutlet var mobileMoneyUgandaContainer: UIView!
    @IBOutlet weak var mobileMoneyUgandaPhone: UITextField!
    
    @IBOutlet weak var mobileMoneyUgandaContentContainer: UIView!
    @IBOutlet weak var mobileMoneyUgandaPayButton: UIButton!
    
    @IBOutlet weak var otherBanksTopAnchor: NSLayoutConstraint!
    @IBOutlet var mpesaBusinessView: UIView!
    @IBOutlet weak var mpesaBusinessNumber: UILabel!
    
    @IBOutlet weak var mpesaAccountNumber: UILabel!
    
    @IBOutlet weak var mobileMoneyVoucher: UITextField!
    @IBOutlet weak var mpesaPendingNoNotification: UILabel!
    @IBOutlet weak var mpesaPendingLabel: UILabel!
    @IBOutlet var mpesaPendingView: UIView!
    @IBOutlet weak var saveCardTableContainer: UIView!
    @IBOutlet weak var mpesaContentContainer: UIView!
    @IBOutlet weak var mobileMoneyContainer: UIView!
    @IBOutlet weak var mobileMoneyChooseNetwork: UITextField!
    @IBOutlet weak var mobileMoneyPhoneNumber: UITextField!
    @IBOutlet weak var mobileMoneyPay: UIButton!
    @IBOutlet weak var mobileMoneyTitle: UILabel!
    @IBOutlet var mobileMoneyPendingView: UIView!
    
    @IBOutlet weak var mobileMoneyPendingLabel: UILabel!
    @IBOutlet var mobileMoneyContentView: UIView!
    
    @IBOutlet var mpesaView: UIView!
    @IBOutlet weak var mpesaPhoneNumber: UITextField!
    @IBOutlet weak var mpesaPayButton: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var cardFieldsContainer: UIView!
    @IBOutlet weak var cardPayButton: UIButton!
    @IBOutlet weak var whatsCVVButton: UIButton!
    @IBOutlet weak var cardCVV: VSTextField!
    @IBOutlet weak var cardExpiry: VSTextField!
    @IBOutlet weak var cardNumberTextField: VSTextField!
    @IBOutlet var debitCardView: UIView!
    @IBOutlet weak var debitCardContentContainer: UIView!
    
    @IBOutlet var pinViewContainer: UIView!
    @IBOutlet var pins: [UIView]!
    @IBOutlet weak var pinContinueButton: UIButton!
    @IBOutlet weak var hiddenPinTextField: UITextField!
    
    @IBOutlet var billingAddressContainer: UIView!
    @IBOutlet weak var billingAddressTextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!    
    @IBOutlet weak var billingContinueButton: UIButton!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var accountContentContainer: UIView!
    @IBOutlet var selectBankAccountView: UIView!
    @IBOutlet weak var accessBankButton: UIButton!
    @IBOutlet weak var providusBankButton: UIButton!
    @IBOutlet weak var sterlingBankButton: UIButton!
    @IBOutlet weak var zenithBankButton: UIButton!
    @IBOutlet weak var otherBanksTextField: UITextField!
    
    @IBOutlet weak var accountBvn: UITextField!
    @IBOutlet weak var accountFormContainer: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var accountNumberTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var accountPayButton: UIButton!
    @IBOutlet weak var accountImageView: UIImageView!
    
    @IBOutlet var otpContentContainer: UIView!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var otpButton: UIButton!
    @IBOutlet weak var otpMessage: UILabel!
    var savedCards:[SavedCard]?
    weak var delegate: RavePayProtocol?
    var loadingView:LoadingHUD!
    var saveCardTableController:SaveCardViewController!
    
    
    
    var amount:String?
    let navBarHeight:CGFloat = ((UIApplication.shared.delegate as? AppDelegate)!.window?.safeAreaInsets.bottom)!
    var expandables = [Expandables(isExpanded: true, section: 0),Expandables(isExpanded: false, section: 1),Expandables(isExpanded: false, section: 2),
                       Expandables(isExpanded: false, section: 3),Expandables(isExpanded: false, section: 4),Expandables(isExpanded: false, section: 5)]
    
    
    var headers = [RavePayHeaderView?]()
    let raveCardClient = RaveCardClient()
    let raveAccountClient = RaveAccountClient()
    let raveMpesaClient = RaveMpesaClient()
    let raveMobileMoney = RaveMobileMoneyClient()
    let raveMobileMoneyUganda = RaveMobileMoneyClient()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var bankPicker:UIPickerView!
    var ghsMobileMoneyPicker:UIPickerView!
    var banks:[Bank]? = [] {
        didSet{
            bankPicker.reloadAllComponents()
        }
    }
    var selectedBankCode:String?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        cardCallbacks()
        accountCallbacks()
        saveCardCallbacks()
        mpesaCallbacks()
        mobileMobileCallbacks()
        mobileMobileUgandaCallbacks()
    }
    
    func saveCardCallbacks(){
        if let _ = RaveConfig.sharedConfig().publicKey{
            if let deviceNumber = RaveConfig.sharedConfig().phoneNumber, deviceNumber != ""{
                LoadingHUD.shared().showInView(view: self.view)
                raveCardClient.fetchSavedCards()
            }
        }
        raveCardClient.sendOTPSuccess = { [weak self](message) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                 LoadingHUD.shared().hide()
                strongSelf.showOTP(message: message ?? "Enter the OTP sent to your mobile phone and email address to continue", flwRef: "", otpType: .savedCard)
            }
        }
        raveCardClient.sendOTPError = {(message) in
            
            DispatchQueue.main.async {
                LoadingHUD.shared().hide()
                showSnackBarWithMessage(msg: message ?? "An error occured while sending OTP")
            }
        }
        
        raveCardClient.saveCardSuccess = {[weak self](saveCards) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                LoadingHUD.shared().hide()
                if let count = saveCards?.count, count > 0 {
                    strongSelf.saveCardContainer.isHidden = false
                    strongSelf.debitCardView.isHidden = true
                    strongSelf.savedCards = saveCards
                    strongSelf.saveCardTableController.savedCards = saveCards
                    strongSelf.saveCardTableController.saveCardTable.reloadData()
                }
            }
            
        }
        raveCardClient.saveCardError = {[weak self](saveCards) in
            guard let strongSelf = self else {
                return
            }
             DispatchQueue.main.async {
                LoadingHUD.shared().hide()
                strongSelf.debitCardView.isHidden = false
                strongSelf.saveCardContainer.isHidden  = true
            }
        }
    }
    
    func accountCallbacks(){
        raveAccountClient.transactionReference = RaveConfig.sharedConfig().transcationRef
        raveAccountClient.banks = {[weak self](banks) in
            if let whitelistedBanks = RaveConfig.sharedConfig().whiteListedBanksOnly{
                var _banks:[Bank] =  []
                whitelistedBanks.forEach({ (code) in
                    let bank = banks?.filter({ (bank) -> Bool in
                        bank.bankCode == code
                    }).first!
                    _banks.append(bank!)
                })
                self?.banks = _banks
                self?.banks = self?.banks?.sorted(by: { (first, second) -> Bool in
                    return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                })
            }else{
                self?.banks = banks
                self?.banks = self?.banks?.sorted(by: { (first, second) -> Bool in
                    return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
                })
            }
            DispatchQueue.main.async {
                self?.bankPicker.reloadAllComponents()
            }
        }
        raveAccountClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.accountPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveAccountClient.chargeSuccess = {[weak self](flwRef,data) in
             LoadingHUD.shared().hide()
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: data)
            self?.dismiss(animated: true)
        }
        
        raveAccountClient.chargeOTPAuth =  {[weak self](flwRef, message) in
             LoadingHUD.shared().hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .bank)
        }
        
        raveAccountClient.redoChargeOTPAuth =  {[weak self](flwRef, message) in
             LoadingHUD.shared().hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .bank)
        }
        
        raveAccountClient.chargeWebAuth = {[weak self](flwRef, authURL) in
             LoadingHUD.shared().hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        raveAccountClient.validateError = {[weak self](message,data) in
             LoadingHUD.shared().hide()
            //Still show success
            if let _data  = data{
                let flwref = _data["flwRef"] as? String
                self?.delegate?.tranasctionSuccessful(flwRef: flwref, responseData: data)
            }else{
                if (message?.containsIgnoringCase(find: "Timed Out"))!{
                   self?.delegate?.tranasctionSuccessful(flwRef: nil,responseData: data)
                }else{
                    self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                }
            }
            self?.dismiss(animated: true)
        }
        raveAccountClient.error = {(message,data) in
             LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "Timed Out"){
                        showSnackBarWithMessage(msg: message ?? "The request timed out")
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred")
                    }
                }
            }
        }
        
    }
    
    func cardCallbacks(){
        raveCardClient.transactionReference = RaveConfig.sharedConfig().transcationRef
        
        raveCardClient.chargeSuccess = {[weak self](flwRef,data) in
             LoadingHUD.shared().hide()
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: data)
            self?.dismiss(animated: true)
        }
        raveCardClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.cardPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveCardClient.chargeSuggestedAuth = {[weak self](authModel, data, authURL) in
             LoadingHUD.shared().hide()
            switch authModel {
            case .AVS_VBVSECURECODE:
                self?.showBillingAddress()
                break
            case .GTB_OTP:
                self?.showPin()
                break
            case .NOAUTH_INTERNATIONAL:
                self?.showBillingAddress()
            case .PIN:
                self?.showPin()
                break
            case .VBVSECURECODE:
                let ref = data?["flwRef"] as? String
                self?.showWebView(url: authURL,ref:ref)
                break
            default:
                break
            }
        }
        
        raveCardClient.error = {(message,data) in
             LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg: message ?? "The request timed out", style: .error)
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred", style: .error)
                    }
                }
            }
        }
        
        raveCardClient.chargeOTPAuth = {[weak self](flwRef, message) in
             LoadingHUD.shared().hide()
            self?.showOTP(message: message, flwRef: flwRef, otpType: .card)
        }
        
        raveCardClient.chargeWebAuth = {[weak self](flwRef, authURL) in
             LoadingHUD.shared().hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        raveCardClient.validateError = {[weak self](message,data) in
             LoadingHUD.shared().hide()
            if let _data  = data{
                let tx = _data["tx"] as? [String:AnyObject]
                let flwref = tx?["flwRef"] as? String
                self?.delegate?.tranasctionSuccessful(flwRef: flwref, responseData: data)
            }else{
                if (message?.containsIgnoringCase(find: "Timed Out"))!{
                    self?.delegate?.tranasctionSuccessful(flwRef: nil, responseData: data)
                }else{
                    self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                }
            }
            self?.dismiss(animated: true)
        }
        
    }
    
    func mpesaCallbacks(){
        raveMpesaClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mpesaPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveMpesaClient.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                guard let strongSelf = self else{ return}
                self?.showMpesaPending(mesage: message ?? "")
                Timer.scheduledTimer(timeInterval: 30, target: strongSelf, selector: #selector(strongSelf.showMpesaPendingNoNotificaction), userInfo: nil, repeats: false)
            }
            
        }
        raveMpesaClient.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: data)
            self?.dismiss(animated: true)
        }
        raveMpesaClient.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
    
    }
    
    func mobileMobileUgandaCallbacks(){
        raveMobileMoneyUganda.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mobileMoneyPay.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveMobileMoneyUganda.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
               
                self?.showMobileMoneyPending(mesage: message ?? "")
            }
            
        }
        raveMobileMoneyUganda.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: data)
            self?.dismiss(animated: true)
        }
        raveMobileMoneyUganda.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
    }
    func mobileMobileCallbacks(){
        raveMobileMoney.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mobileMoneyPay.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveMobileMoney.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                let customMessage = RaveConstants.ghsMobileNetworks.filter({ (it) -> Bool in
                    return it.0 == self?.raveMobileMoney.selectedMobileNetwork!
                }).first?.2
                
                print(customMessage ?? "")
                self?.showMobileMoneyPending(mesage: customMessage ?? "")
            }

        }
        raveMobileMoney.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: data)
            self?.dismiss(animated: true)
        }
        raveMobileMoney.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil, responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        debitCardView.frame = debitCardContentContainer.frame
        pinViewContainer.frame = debitCardContentContainer.frame
        saveCardContainer.frame = debitCardContentContainer.frame
        mpesaPendingView.frame = mpesaContentContainer.frame
        mpesaView.frame = mpesaContentContainer.frame
        mpesaBusinessView.frame = mpesaContentContainer.frame
        mobileMoneyContentView.frame = mobileMoneyContainer.frame
        mobileMoneyPendingView.frame = mobileMoneyContainer.frame
        
        selectBankAccountView.frame = accountContentContainer.frame
        accountFormContainer.frame = accountContentContainer.frame
        
        mobileMoneyUgandaContainer.frame = mobileMoneyUgandaContentContainer.frame
        self.saveCardTableController.view.frame = self.saveCardTableContainer.bounds
        
        billingAddressContainer.frame = debitCardContentContainer.frame
        cardFieldsContainer.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        accessBankButton.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        sterlingBankButton.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        providusBankButton.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        zenithBankButton.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        otherBanksTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        billingAddressTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        cityTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        stateTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        zipCodeTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        countryTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        
        phoneNumberTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        accountNumberTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
        dobTextField.addShadow(offset: CGSize(width: 1, height: 1), color: UIColor(hex: "#323236"), radius: 4, opacity: 0.13)
    }
    
    func configureView(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let closeButton = UIButton(type: .system)
        closeButton.tintColor = UIColor(hex: "#D9D9D9")
        closeButton.setImage(#imageLiteral(resourceName: "rave_close"), for: .normal)
        closeButton.frame = CGRect(x: 0, y:0, width: 40, height: 40)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        let navTitle = RavePayNavTitle(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        navTitle.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navTitle)
        
        self.tableView.backgroundColor = UIColor(hex: "#F2F2F2")
        self.tableView.tableFooterView = UIView(frame: .zero)
        let debitCardHeader = getHeader()
        let bankAccountHeader = getHeader()
        let mpesaHeader = getHeader()
        let ghanaMobileMoneyHeader = getHeader()
        let ugandaMobileMoneyHeader = getHeader()
        headers = [nil,debitCardHeader,bankAccountHeader, mpesaHeader,ghanaMobileMoneyHeader,ugandaMobileMoneyHeader]
        raveAccountClient.getBanks()
        configureDebitCardView()
        configureBankView()
        configureOTPView()
        configureMpesaView()
        configureMobileMoney()
        configureMobileMoneyUganda()
    }
    
    func configureDebitCardView(){
         debitCardContentContainer.addSubview(saveCardContainer)
         debitCardContentContainer.addSubview(debitCardView)
         debitCardContentContainer.addSubview(pinViewContainer)
         debitCardContentContainer.addSubview(billingAddressContainer)
         pinViewContainer.isHidden = true
         saveCardContainer.isHidden = true
         billingAddressContainer.isHidden = true
         cardFieldsContainer.layer.cornerRadius = 5
         cardPayButton.layer.cornerRadius = 5
         cardNumberTextField.setFormatting("xxxx xxxx xxxx xxxx xxxx", replacementChar: "x")
         cardNumberTextField.delegate = self
         cardNumberTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
         cardExpiry.setFormatting("xx/xx", replacementChar: "x")
         cardExpiry.delegate = self
         cardCVV.setFormatting("xxxx", replacementChar: "x")
         cardCVV.delegate = self
         cardPayButton.addTarget(self, action: #selector(cardPayButtonTapped), for: .touchUpInside)
         cardPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        
        useAnotherCardButton.addTarget(self, action: #selector(showDebitCardView), for: .touchUpInside)
        rememberCardCheck.addTarget(self, action: #selector(toggleSaveCardCheck), for: .touchUpInside)
        rememberCardText.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(toggleSaveCardCheck)))
        rememberCardText.isUserInteractionEnabled = true
        
        let storyboard = UIStoryboard(name: "Rave", bundle: nil)
        saveCardTableController = storyboard.instantiateViewController(withIdentifier: "saveCard") as! SaveCardViewController
        saveCardTableController.delegate = self
        self.addChild(saveCardTableController)
        self.saveCardTableContainer.addSubview(saveCardTableController.view)
        saveCardTableController.view.clipsToBounds = true
        saveCardTableController.didMove(toParent: self)
        
        
        pinContinueButton.layer.cornerRadius = 5
        pinContinueButton.addTarget(self, action: #selector(pinContinueButtonTapped), for: .touchUpInside)
        for _view in pins{
            _view.layer.cornerRadius = 3
            _view.isUserInteractionEnabled = true
            _view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPinKeyboard)))
        }
        hiddenPinTextField.delegate = self
        hiddenPinTextField.isHidden = true
        hiddenPinTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        billingAddressTextField.layer.cornerRadius = 5
        billingAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        billingAddressTextField.leftViewMode = .always
        billingAddressTextField.delegate = self
        stateTextField.layer.cornerRadius = 5
        stateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        stateTextField.leftViewMode = .always
        stateTextField.delegate = self
        cityTextField.layer.cornerRadius = 5
        cityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        cityTextField.leftViewMode = .always
        cityTextField.delegate = self
        countryTextField.layer.cornerRadius = 5
        countryTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        countryTextField.leftViewMode = .always
        countryTextField.delegate = self
        zipCodeTextField.layer.cornerRadius = 5
        zipCodeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        zipCodeTextField.leftViewMode = .always
        zipCodeTextField.delegate = self
        
        billingContinueButton.layer.cornerRadius = 5
        billingContinueButton.addTarget(self, action: #selector(billAddressButtonTapped), for: .touchUpInside)
    }
    
    func configureBankView(){
        accountContentContainer.addSubview(selectBankAccountView)
        accountContentContainer.addSubview(accountFormContainer)
        accountFormContainer.isHidden = true
        accessBankButton.layer.cornerRadius = 5
        accessBankButton.tag = 044
        accessBankButton.addTarget(self, action: #selector(accessButtonTapped(_:)), for: .touchUpInside)
        sterlingBankButton.layer.cornerRadius = 5
        sterlingBankButton.tag = 232
        sterlingBankButton.addTarget(self, action: #selector(sterlingButtonTapped(_:)), for: .touchUpInside)
        providusBankButton.layer.cornerRadius = 5
        providusBankButton.tag = 101
        providusBankButton.addTarget(self, action: #selector(providusButtonTapped(_:)), for: .touchUpInside)
        zenithBankButton.layer.cornerRadius = 5
        zenithBankButton.tag = 057
        zenithBankButton.addTarget(self, action: #selector(zenithButtonTapped(_:)), for: .touchUpInside)
        goBack.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        //access - 044 , sterling - 232 , zenith - 057, providus -101
        let dropButton = UIButton(type: .custom)
        dropButton.frame = CGRect(x: 0, y: 0, width: otherBanksTextField.frame.height, height: otherBanksTextField.frame.height)
        dropButton.setImage(#imageLiteral(resourceName: "dropdown"), for: .normal)
        dropButton.addTarget(self, action: #selector(selectBankArrowTapped), for: .touchUpInside)
        self.otherBanksTextField.rightView =  dropButton
        self.otherBanksTextField.rightViewMode = .always
        otherBanksTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        otherBanksTextField.leftViewMode = .always
        otherBanksTextField.layer.cornerRadius = 5
        bankPicker = UIPickerView()
        bankPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        bankPicker.showsSelectionIndicator = true
        bankPicker.delegate = self
        bankPicker.dataSource = self
        bankPicker.tag = 12
        self.otherBanksTextField.delegate = self
        
        self.otherBanksTextField.inputView = bankPicker
        
        phoneNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        phoneNumberTextField.leftViewMode = .always
        phoneNumberTextField.layer.cornerRadius = 5
        phoneNumberTextField.text = RaveConfig.sharedConfig().phoneNumber
        
        accountNumberTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        accountNumberTextField.leftViewMode = .always
        accountNumberTextField.layer.cornerRadius = 5
        
        dobTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        dobTextField.leftViewMode = .always
        dobTextField.layer.cornerRadius = 5
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dobTextField.inputView = dp
        dp.addTarget(self, action: #selector(dobPickerValueChanged), for: .valueChanged)
        
        accountBvn.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        accountBvn.leftViewMode = .always
        accountBvn.layer.cornerRadius = 5
        
        accountPayButton.layer.cornerRadius = 5
        accountPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        accountPayButton.addTarget(self, action: #selector(accountPayButtonTapped), for: .touchUpInside)
        raveAccountClient.amount = self.amount
        raveAccountClient.getFee()
        
        if let count = RaveConfig.sharedConfig().whiteListedBanksOnly?.count, count > 0{
//            accessBankButton.isEnabled = false
//            sterlingBankButton.isEnabled = false
//            providusBankButton.isEnabled = false
//            zenithBankButton.isEnabled = false
            accessBankButton.isHidden = true
            sterlingBankButton.isHidden = true
            providusBankButton.isHidden = true
            zenithBankButton.isHidden = true
            orLabel.isHidden = true
            self.otherBanksTopAnchor.constant = -66
            self.view.layoutSubviews()
        }
        
    }
    func configureMpesaView(){
        raveMpesaClient.transactionReference = RaveConfig.sharedConfig().transcationRef
        mpesaContentContainer.addSubview(mpesaView)
        mpesaContentContainer.addSubview(mpesaPendingView)
         mpesaContentContainer.addSubview(mpesaBusinessView)
        mpesaPendingView.isHidden = true
        mpesaBusinessView.isHidden = true
        mpesaPhoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        mpesaPhoneNumber.leftViewMode = .always
        mpesaPhoneNumber.layer.cornerRadius = 5
        
        mpesaPayButton.layer.cornerRadius = 5
        mpesaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mpesaPayButton.addTarget(self, action: #selector(mpesaPayButtonTapped), for: .touchUpInside)
        
        raveMpesaClient.amount = self.amount
        raveMpesaClient.email = RaveConfig.sharedConfig().email
        raveMpesaClient.getFee()
    }
    
    func configureMobileMoney(){
        raveMobileMoney.transactionReference = RaveConfig.sharedConfig().transcationRef
        mobileMoneyContainer.addSubview(mobileMoneyContentView)
        mobileMoneyContainer.addSubview(mobileMoneyPendingView)
        mobileMoneyPendingView.isHidden = true
        ghsMobileMoneyPicker = UIPickerView()
        ghsMobileMoneyPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        ghsMobileMoneyPicker.showsSelectionIndicator = true
        ghsMobileMoneyPicker.delegate = self
        ghsMobileMoneyPicker.dataSource = self
        ghsMobileMoneyPicker.tag = 13
        self.mobileMoneyChooseNetwork.delegate = self
        self.mobileMoneyChooseNetwork.inputView = ghsMobileMoneyPicker
        mobileMoneyChooseNetwork.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        mobileMoneyChooseNetwork.leftViewMode = .always
        mobileMoneyChooseNetwork.layer.cornerRadius = 5
        
        mobileMoneyPhoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        mobileMoneyPhoneNumber.leftViewMode = .always
        mobileMoneyPhoneNumber.layer.cornerRadius = 5
        
        mobileMoneyVoucher.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        mobileMoneyVoucher.keyboardType = .default
        mobileMoneyVoucher.leftViewMode = .always
        mobileMoneyVoucher.layer.cornerRadius = 5
        
        mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyPay.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyPay.addTarget(self, action: #selector(mobileMoneyPayAction), for: .touchUpInside)
        
        raveMobileMoney.amount = self.amount
        raveMobileMoney.email = RaveConfig.sharedConfig().email
        raveMobileMoney.getFee()
    }
    
    func configureMobileMoneyUganda(){
        raveMobileMoneyUganda.transactionReference = RaveConfig.sharedConfig().transcationRef
        mobileMoneyUgandaContentContainer.addSubview(mobileMoneyUgandaContainer)
        mobileMoneyUgandaContentContainer.addSubview(mobileMoneyPendingView)
        mobileMoneyPendingView.isHidden = true

        
        mobileMoneyUgandaPhone.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        mobileMoneyUgandaPhone.leftViewMode = .always
        mobileMoneyUgandaPhone.layer.cornerRadius = 5
        
       
        
        mobileMoneyUgandaPayButton.layer.cornerRadius = 5
        mobileMoneyUgandaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyUgandaPayButton.addTarget(self, action: #selector(mobileMoneyUgandaPayAction), for: .touchUpInside)
        
        raveMobileMoneyUganda.amount = self.amount
        raveMobileMoneyUganda.email = RaveConfig.sharedConfig().email
        raveMobileMoneyUganda.getFee()
    }
    
    func configureOTPView(){
        
        otpTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        otpTextField.leftViewMode = .always
        otpTextField.layer.cornerRadius = 5
        self.otpButton.layer.cornerRadius = 5
        self.otpButton.addTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
    }
    
    
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        
          return expandables.count
    
    }
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return expandables[section].isExpanded ? 1 : 0
        
    }
    
    override public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
            case 0:
                return 0
            case 1:
                //||  RaveConfig.sharedConfig().country == "UG"
                return RaveConfig.sharedConfig().country == "KE" || RaveConfig.sharedConfig().country == "GH"  ? 0 :  65
            case 2:
                return RaveConfig.sharedConfig().country == "NG" || RaveConfig.sharedConfig().country == "US" || RaveConfig.sharedConfig().country == "ZA" ? 65 : 0
            case 3:
                return RaveConfig.sharedConfig().country == "KE" ? 65 : 0
            case 4:
                return RaveConfig.sharedConfig().country == "GH" ? 65 : 0
            case 5:
                return RaveConfig.sharedConfig().country == "UG" ? 65 : 0
        default:
            return 0
        }
        
    }

    override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
            switch section {
            case 0:
                return nil
                
            case 1:
                let headerTitle = "Pay with your Debit Card"
                let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
                attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Debit Card")!, in: headerTitle))
                headers[1]?.titleLabel.attributedText = attributedString
                headers[1]?.arrowButton.tag = 1
                headers[1]?.button.tag = 1
                return headers[1]
            case 2:
                let headerTitle = "Pay with your Bank Account"
                let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
                attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Bank Account")!, in: headerTitle))
                headers[2]?.titleLabel.attributedText = attributedString
                headers[2]?.arrowButton.tag = 2
                headers[2]?.button.tag = 2
                return headers[2]
            case 3:
                let headerTitle = "Pay with M-PESA"
                let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
                attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "M-PESA")!, in: headerTitle))
                headers[3]?.titleLabel.attributedText = attributedString
                headers[3]?.arrowButton.tag = 3
                headers[3]?.button.tag = 3
                return headers[3]
            case 4:
                let headerTitle = "Pay with Mobile Money"
                let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
                attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money")!, in: headerTitle))
                headers[4]?.titleLabel.attributedText = attributedString
                headers[4]?.arrowButton.tag = 4
                headers[4]?.button.tag = 4
                return headers[4]
            case 5:
                let headerTitle = "Pay with Mobile Money Uganda"
                let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
                attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Uganda")!, in: headerTitle))
                headers[5]?.titleLabel.attributedText = attributedString
                headers[5]?.arrowButton.tag = 5
                headers[5]?.button.tag = 5
                return headers[5]
            default:
                return nil
                
            }
        
        
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  return expandables[indexPath.section].isExpanded ? self.view.frame.height - (180) : 0
        
            switch indexPath.section {
            case 0:
                return expandables[indexPath.section].isExpanded ? self.view.frame.height - (200 + navBarHeight) : 0
            case 1:
                return expandables[indexPath.section].isExpanded ? 400 : 0
            case 2:
                return expandables[indexPath.section].isExpanded ? 600 : 0
            case 3:
                return expandables[indexPath.section].isExpanded ? 400 : 0
            case 4:
                return expandables[indexPath.section].isExpanded ? 400 : 0
            case 5:
                return expandables[indexPath.section].isExpanded ? 400 : 0
            default:
                return expandables[indexPath.section].isExpanded ? self.view.frame.height - (200 + navBarHeight) : 0
            }
        
    }
    
    
    
    
}

extension RavePayViewController : UITextFieldDelegate,RavePayWebProtocol,UIPickerViewDelegate,UIPickerViewDataSource,CardSelect {
    func cardSelected(card: SavedCard?) {
        raveCardClient.selectedCard = card
        if let card =  raveCardClient.selectedCard{
            LoadingHUD.shared().show()
            raveCardClient.sendOTP(card: card)
        }
    }

    func tranasctionSuccessful(flwRef: String,responseData:[String:Any]?) {
        // showSnackBarWithMessage(msg:"Payment Successful")
        self.dismiss(animated: true) {
            self.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData:responseData)
        }
    }
    
    
    func getHeader()-> RavePayHeaderView{
        let header = RavePayHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65))
        header.backgroundColor = UIColor(hex: "#FBEED8")
        header.button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        return header
    }
    @objc func showPinKeyboard(){
        self.hiddenPinTextField.becomeFirstResponder()
    }
    
    @objc func handleButtonTap(_ sender:UIButton){
        self.handelCloseOrExpandSection(section: sender.tag)
    }
    
    @objc func closeView(){
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
    
    
    func handelCloseOrExpandSection(section:Int){
        let expandedState = expandables[section].isExpanded
        if expandedState{
            //Collapse the expanded state and expaand the first section
            expandables[0].isExpanded = true
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            expandables[section].isExpanded = false
            self.tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .fade)
            self.headers[section]?.arrowButton.setImage(#imageLiteral(resourceName: "rave_up_arrow"), for: .normal)
        }else{
            //Expand current view and collapse the other sections
            var expandedIndexPath = [IndexPath]()
            var newExpandables = [Expandables]()
            for item in self.expandables{
                if item.isExpanded == true{
                    expandedIndexPath.append(IndexPath(row: 0, section: item.section))
                    self.headers[section]?.arrowButton.setImage(#imageLiteral(resourceName: "rave_up_arrow"), for: .normal)
                }
            }
            
            for item in self.expandables{
                newExpandables.append(Expandables(isExpanded: false, section: item.section))
                self.headers[item.section]?.arrowButton.setImage(#imageLiteral(resourceName: "rave_up_arrow"), for: .normal)
            }
            self.expandables = newExpandables
            
            
            self.tableView.deleteRows(at: expandedIndexPath, with: .fade)
            //expandables[0].isExpanded = false
            
            
            self.expandables[section].isExpanded = true
            self.headers[section]?.arrowButton.setImage(#imageLiteral(resourceName: "rave_down_arrow"), for: .normal)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: section)], with: .fade)
            //Check if selected tab is Bank Account and Country is US
            if section == 2{
                self.chargeUSAccountFlow()
                self.chargeSAAccountFlow()
            }
        }
    }
    
    
    //MARK: Card payment
    @objc func cardPayButtonTapped(){
        guard let cardNumber = self.cardNumberTextField.text, cardNumber != "" else
        {
            self.cardNumberTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.cardNumberTextField.layer.borderWidth = 0.5
            return  }
        guard let expiry = self.cardExpiry.text, expiry != "" else
        {
            self.cardExpiry.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.cardExpiry.layer.borderWidth = 0.5
            return
            
        }
        guard let cvv = self.cardCVV.text, cvv != "" else
        {
            self.cardCVV.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.cardCVV.layer.borderWidth = 0.5
            return
            
        }
        self.cardPayAction()
    }
    
    @objc func toggleSaveCardCheck(){
        raveCardClient.saveCard =  !raveCardClient.saveCard
        let image =  raveCardClient.saveCard == true ? UIImage(named:"rave_check_box") :  UIImage(named:"rave_unchecked_box")
        rememberCardCheck.setImage(image, for: .normal)
    }
    
    func showWebView(url: String?,ref:String?){
        //Collapse opened Tabs
        self.handelCloseOrExpandSection(section: 0)
        //Show web view
        let storyBoard = UIStoryboard(name: "Rave", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "web") as! RavePayWebViewController
        controller.flwRef = ref
        controller.url = url
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func showMpesaPending(mesage:String){
        mpesaPendingView.isHidden = false
        mpesaPendingView.alpha = 0
        mpesaPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mpesaPendingView.alpha = 1
            self.mpesaView.alpha = 0
        }) { (completed) in
            self.mpesaView.isHidden = true
          
        }
    }
    @objc func showMpesaPendingNoNotificaction(){
        self.mpesaPendingNoNotification.isHidden = false
        self.mpesaPendingNoNotification.isUserInteractionEnabled = true
        self.mpesaPendingNoNotification.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMpesaBusinessView)))
    }
    
    @objc func showMpesaBusinessView(){
        mpesaBusinessView.isHidden = false
        mpesaBusinessView.alpha = 0
        mpesaBusinessNumber.text = raveMpesaClient.businessNumber
        mpesaAccountNumber.text = raveMpesaClient.accountNumber
        UIView.animate(withDuration: 0.6, animations: {
            self.mpesaBusinessView.alpha = 1
            self.mpesaPendingView.alpha = 0
        }) { (completed) in
            self.mpesaPendingView.isHidden = true
            
        }
    }
    func showMobileMoneyPending(mesage:String){
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyContentView.alpha = 0
        }) { (completed) in
            self.mobileMoneyContentView.isHidden = true
            
        }
    }
    
    func showBillingAddress(){
        billingAddressContainer.isHidden = false
        billingAddressContainer.alpha = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.billingAddressContainer.alpha = 1
            self.debitCardView.alpha = 0
            self.pinViewContainer.alpha = 0
        }) { (completed) in
            self.debitCardView.isHidden = true
            self.pinViewContainer.isHidden = true
        }
    }
    
    func showPin(){
        pinViewContainer.isHidden = false
        pinViewContainer.alpha = 0
        debitCardView.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.pinViewContainer.alpha = 1
            self.debitCardView.alpha = 0
        }) { (completed) in
            self.debitCardView.isHidden = true
            self.hiddenPinTextField.becomeFirstResponder()
        }
       
    }
    @objc func showDebitCardView(){
        debitCardView.isHidden = false
        debitCardView.alpha = 0
        saveCardContainer.alpha = 1
        UIView.animate(withDuration: 0.6, animations: {
            self.debitCardView.alpha = 1
            self.saveCardContainer.alpha = 0
        }) { (completed) in
            self.saveCardContainer.isHidden = true
        }
    }
    @objc func textFieldDidChange(textField: UITextField) {
        if (textField == hiddenPinTextField){
            pins.forEach { (item) in
                item.backgroundColor = .white
            }
           
            for (index,_) in (textField.text?.enumerated())!{
                pins[index].backgroundColor = .gray
            }
            if ((textField.text?.count)! == 4){
                textField.resignFirstResponder()
            }
            
        }
        if (textField == cardNumberTextField){
            if let count = textField.text?.count {
                if count == 6{
                  raveCardClient.amount = self.amount
                  raveCardClient.cardfirst6 = textField.text
                  raveCardClient.getFee()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        if textField == otherBanksTextField{
            if let count = self.banks?.count, count > 0{
                bankPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(bankPicker, didSelectRow: 0, inComponent: 0)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == otherBanksTextField {
            let colorStyle = RaveConstants.bankStyle.filter { (item) -> Bool in
                   return item.code == selectedBankCode!
            }.first
            if let style = colorStyle{
                let isdobHidden = (style.code == "057" || style.code == "033")  ? false : true
                let isBvnHidden = style.code == "033" ? false : true
                showAccountFormScreen(withBackGround: style.color, imageName: style.image, dobFieldHidden: isdobHidden, bvnFieldHidden: isBvnHidden)
            }else{
                showAccountFormScreen()
            }
        }
    }
    
    func showOTP(message:String, flwRef:String, otpType:OTPType){
        switch otpType {
        case .savedCard:
            debitCardContentContainer.addSubview(otpContentContainer)
            otpContentContainer.frame = debitCardContentContainer.frame
            otpContentContainer.alpha = 0
            otpMessage.text = message
            otpButton.removeTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            otpButton.removeTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
            otpButton.addTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
            
            UIView.animate(withDuration: 0.6, animations: {
                self.otpContentContainer.alpha = 1
                self.pinViewContainer.alpha = 0
                self.debitCardView.alpha = 0
            }) { (success) in
                self.pinViewContainer.isHidden = true
                self.debitCardView.isHidden = true
            }
            
        case .card:
           debitCardContentContainer.addSubview(otpContentContainer)
           otpContentContainer.frame = debitCardContentContainer.frame
           otpContentContainer.alpha = 0
           otpMessage.text = message
           otpButton.removeTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
           otpButton.removeTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
           otpButton.addTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
           
           
           raveCardClient.transactionReference = flwRef
           UIView.animate(withDuration: 0.6, animations: {
            self.otpContentContainer.alpha = 1
            self.pinViewContainer.alpha = 0
            self.debitCardView.alpha = 0
           }) { (success) in
             self.pinViewContainer.isHidden = true
             self.debitCardView.isHidden = true
          }
        case .bank:
            accountContentContainer.addSubview(otpContentContainer)
            otpContentContainer.frame = debitCardContentContainer.frame
            otpContentContainer.alpha = 0
            otpMessage.text = message
            otpTextField.text = ""
            otpButton.removeTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
            otpButton.removeTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
            otpButton.addTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            raveAccountClient.transactionReference = flwRef
            UIView.animate(withDuration: 0.6, animations: {
                self.otpContentContainer.alpha = 1
                self.accountFormContainer.alpha = 0
                self.selectBankAccountView.alpha = 0
            }) { (success) in
                self.accountFormContainer.isHidden = true
                self.selectBankAccountView.isHidden = true
            }
        }
    }
    
    
    @objc func billAddressButtonTapped(){
        guard let zip = self.zipCodeTextField.text, zip != "" else{
            self.zipCodeTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.zipCodeTextField.layer.borderWidth = 0.5
            return
        }
        guard let city = self.cityTextField.text, city != "" else{
            self.zipCodeTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.zipCodeTextField.layer.borderWidth = 0.5
            return
        }
        guard let address = self.billingAddressTextField.text, address != "" else{
            self.billingAddressTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.billingAddressTextField.layer.borderWidth = 0.5
            return
        }
        guard let country = self.countryTextField.text, country != "" else{
            self.countryTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.countryTextField.layer.borderWidth = 0.5
            return
        }
        guard let state = self.stateTextField.text, state != "" else{
            self.stateTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.stateTextField.layer.borderWidth = 0.5
            return
        }
       self.billAddressAction()
    }
    
    func billAddressAction(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        guard let zip = self.zipCodeTextField.text, let city = self.cityTextField.text,
            let address = self.billingAddressTextField.text, let country = self.countryTextField.text , let state = self.stateTextField.text else {return}
        raveCardClient.bodyParam?.merge(["suggested_auth":"NOAUTH_INTERNATIONAL","billingzip":zip,"billingcity":city,
                                         "billingaddress":address,"billingstate":state, "billingcountry":country])
        raveCardClient.chargeCard()
    }
    
    @objc func cardOTPButtonTapped(){
        self.view.endEditing(true)
         LoadingHUD.shared().show()
        guard let otp = otpTextField.text, otp != ""  else {
            return
        }
        raveCardClient.otp = otp
        raveCardClient.validateCardOTP()
    }
    
    @objc func saveCardOTPButtonTapped(){
        self.view.endEditing(true)
        guard let otp = otpTextField.text, otp != ""  else {
            return
        }
        LoadingHUD.shared().show()
        raveCardClient.otp = otp
        raveCardClient.isSaveCardCharge = "1"
        raveCardClient.saveCardPayment = "saved-card"
        raveCardClient.amount = self.amount
        raveCardClient.saveCardCharge()
    }
    
  
    @objc func pinContinueButtonTapped(){
        self.pinAction()
    }
    
    func pinAction(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        guard let pin = self.hiddenPinTextField.text else {return}
        raveCardClient.bodyParam?.merge(["suggested_auth":"PIN","pin":pin])
        raveCardClient.chargeCard()
    }
    
    func cardPayAction(){
        self.view.endEditing(true)
         LoadingHUD.shared().show()
        raveCardClient.cardNumber = self.cardNumberTextField.text?.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
        raveCardClient.cvv = self.cardCVV.text
        raveCardClient.expYear = String(self.cardExpiry.text.dropFirst(2))
        raveCardClient.expMonth = String(self.cardExpiry.text.prefix(2))
        raveCardClient.amount = self.amount
        raveCardClient.chargeCard()
        
    }
    //MARK: Mobile Mone\y Payment
    @objc func mobileMoneyPayButtonTapped(){
        self.mpesaPayAction()
    }
    
    @objc func mobileMoneyPayAction(){
        guard let number = mobileMoneyPhoneNumber.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMobileMoney.network = mobileMoneyChooseNetwork.text
        raveMobileMoney.voucher = mobileMoneyVoucher.text
        raveMobileMoney.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoney.chargeMobileMoney()
    }
    
    @objc func mobileMoneyUgandaPayAction(){
        guard let number = mobileMoneyUgandaPhone.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMobileMoneyUganda.mobileMoneyType = .uganda
        raveMobileMoneyUganda.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoneyUganda.chargeMobileMoney(.uganda)
    }
    //MARK: MPESA Payment
    @objc func mpesaPayButtonTapped(){
        self.mpesaPayAction()
    }
    
    func mpesaPayAction(){
        guard let number = mpesaPhoneNumber.text , number != "" else{
                return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMpesaClient.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMpesaClient.chargeMpesa()
    }
    
    //MARK:  Account Payment
    @objc func dobPickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.dobTextField.text = selectedDate
    }
    @objc func accountOTPButtonTapped(){
        self.view.endEditing(true)
        
        guard let otp = otpTextField.text, otp != ""  else {
            return
        }
        LoadingHUD.shared().show()
        raveAccountClient.otp = otp
        raveAccountClient.validateAccountOTP()
    }
    
    @objc func accountPayButtonTapped(){
        self.accountPayAction()
    }
    
    func accountPayAction(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveAccountClient.accountNumber = accountNumberTextField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveAccountClient.phoneNumber = phoneNumberTextField.text
        raveAccountClient.amount = self.amount
        raveAccountClient.bankCode = selectedBankCode
        if let passcode = self.dobTextField.text , passcode != "" {
            raveAccountClient.passcode = passcode
        }
        if let bvn = self.accountBvn.text , bvn != "" {
            raveAccountClient.bvn = bvn
        }
        raveAccountClient.chargeAccount()
    }
    func chargeUSAccountFlow(){
        self.view.endEditing(true)
        if RaveConfig.sharedConfig().country == .some("US"){
            LoadingHUD.shared().show()
            raveAccountClient.isUSBankAccount = true
            raveAccountClient.amount = self.amount
            raveAccountClient.phoneNumber = RaveConfig.sharedConfig().phoneNumber
            raveAccountClient.chargeAccount()
            
        }
    }
    
    func chargeSAAccountFlow(){
        self.view.endEditing(true)
        if RaveConfig.sharedConfig().country == .some("ZA"){
            LoadingHUD.shared().show()
            raveAccountClient.amount = self.amount
            raveAccountClient.accountNumber = "00000"
            raveAccountClient.bankCode = "093"
            raveAccountClient.phoneNumber = RaveConfig.sharedConfig().phoneNumber
            raveAccountClient.chargeAccount()
        }
    }
    
    @objc func sterlingButtonTapped(_ sender:UIButton){
        self.selectedBankCode = "232"
        self.selectedBankCode = "\(sender.tag)"
         let colorStyle = RaveConstants.bankStyle.filter { (item) -> Bool in
            return item.code ==  self.selectedBankCode
         }.first
        if let style = colorStyle{
            showAccountFormScreen(withBackGround: style.color, imageName: style.image, dobFieldHidden: true)
        }else{
            showAccountFormScreen()
        }
    }
    @objc func zenithButtonTapped(_ sender:UIButton){
        self.selectedBankCode = "057"
       
        let colorStyle = RaveConstants.bankStyle.filter { (item) -> Bool in
            return item.code ==  self.selectedBankCode
            }.first
        if let style = colorStyle{
            showAccountFormScreen(withBackGround: style.color, imageName: style.image, dobFieldHidden: false)
        }else{
            showAccountFormScreen()
        }
    }
    @objc func accessButtonTapped(_ sender:UIButton){
        self.selectedBankCode = "044"
        let colorStyle = RaveConstants.bankStyle.filter { (item) -> Bool in
            return item.code ==  self.selectedBankCode
            }.first
        if let style = colorStyle{
            showAccountFormScreen(withBackGround: style.color, imageName: style.image, dobFieldHidden: true)
        }else{
            showAccountFormScreen()
        }
    }
    @objc func providusButtonTapped(_ sender:UIButton){
        self.selectedBankCode = "101"
        let colorStyle = RaveConstants.bankStyle.filter { (item) -> Bool in
            return item.code ==  self.selectedBankCode
            }.first
        if let style = colorStyle{
            showAccountFormScreen(withBackGround: style.color, imageName: style.image, dobFieldHidden: true)
        }else{
            showAccountFormScreen()
        }
    }
    
    func showAccountFormScreen(withBackGround backgroundColor:String = "#f2f2f2", imageName:String = "", dobFieldHidden:Bool = true, bvnFieldHidden:Bool = true ){
        accountFormContainer.isHidden = false
        accountFormContainer.alpha = 0
        //selectBankAccountView
        UIView.animate(withDuration: 0.6, animations: {
            self.accountFormContainer.alpha = 1
            self.accountFormContainer.backgroundColor = UIColor(hex: "#f2f2f2")
            self.accountImageView.image = UIImage(named: imageName)
            self.dobTextField.isHidden = dobFieldHidden
            self.accountBvn.isHidden = bvnFieldHidden
            self.selectBankAccountView.alpha = 0
        }) { (succeeded) in
            self.selectBankAccountView.isHidden = true
        }
    }
    @objc func goBackButtonTapped(){
        self.selectBankAccountView.isHidden = false
        self.selectBankAccountView.alpha = 0
        self.accountNumberTextField.text = ""
        self.phoneNumberTextField.text = ""
        self.dobTextField.text = ""
        UIView.animate(withDuration: 0.6, animations: {
            self.accountFormContainer.alpha = 0
        
            self.selectBankAccountView.alpha = 1
        }) { (succeeded) in
            self.accountFormContainer.isHidden = true
            self.dobTextField.isHidden = true
        }
    }
    @objc func selectBankArrowTapped(){
        self.otherBanksTextField.becomeFirstResponder()
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 12 {
            if let count = self.banks?.count{
                return count
            }else{
                return 0
            }
        }else{
            return RaveConstants.ghsMobileNetworks.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 12 {
            return self.banks?[row].name
        }else{
            return RaveConstants.ghsMobileNetworks[row].0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 12 {
            self.selectedBankCode = self.banks?[row].bankCode
            self.otherBanksTextField.text = self.banks?[row].name
        }else{
            self.mobileMoneyChooseNetwork.text = RaveConstants.ghsMobileNetworks[row].0
            self.mobileMoneyTitle.text = RaveConstants.ghsMobileNetworks[row].1
            
            if (RaveConstants.ghsMobileNetworks[row].0 == "VODAFONE"){
              mobileMoneyVoucher.isHidden = false
            }else{
              mobileMoneyVoucher.isHidden = true
            }
            raveMobileMoney.selectedMobileNetwork = RaveConstants.ghsMobileNetworks[row].0
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
