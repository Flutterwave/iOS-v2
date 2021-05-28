//
//  NewRavePayViewController.swift
//  RaveTest
//
//  Created by Olusegun Solaja on 05/09/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class Expandables{
    var isExpanded:Bool
    var section:Int

    init(isExpanded:Bool,section:Int) {
        self.isExpanded = isExpanded
        self.section = section
    }
}

enum OTPType {
    case card, bank, savedCard
}
//protocol  RavePayProtocol : class{
//    func tranasctionSuccessful(flwRef:String?)
//    func tranasctionFailed(flwRef:String?)
//}
public protocol  RavePayProtocol : class{
    func tranasctionSuccessful(flwRef:String?, responseData:[String:Any]?)
    func tranasctionFailed(flwRef:String?,responseData:[String:Any]?)
    func onDismiss()
}


@available(iOS 11.0, *)
public class NewRavePayViewController: UITableViewController {
    var howCell: UITableViewCell = UITableViewCell()
    var cardCell: UITableViewCell = UITableViewCell()
    var accountCell: UITableViewCell = UITableViewCell()
    var mpesaCell: UITableViewCell = UITableViewCell()
    var mobileMoneyGH: UITableViewCell = UITableViewCell()
    var mobileMoneyUG: UITableViewCell = UITableViewCell()
    var mobileMoneyRW: UITableViewCell = UITableViewCell()
    var mobileMoneyFR: UITableViewCell = UITableViewCell()
    var mobileMoneyZM: UITableViewCell = UITableViewCell()
    var ukAccountCell: UITableViewCell = UITableViewCell()
    
    let navBarHeight:CGFloat = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
    
    var expandables = [Expandables(isExpanded: true, section: 0),Expandables(isExpanded: false, section: 1),Expandables(isExpanded: false, section: 2),Expandables(isExpanded: false, section: 3),Expandables(isExpanded: false, section: 4),Expandables(isExpanded: false, section: 5),Expandables(isExpanded: false, section: 6),Expandables(isExpanded: false, section: 7),Expandables(isExpanded: false, section: 8),Expandables(isExpanded: false, section: 9)]
    
    var headers = [RavePayHeaderView?]()
    public var delegate: RavePayProtocol?
    lazy var howView: HowView = {
        let b = HowView()
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    lazy var  debitCardContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ukContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var  accountContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var  mobileMoneyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyUgandaContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyRWContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyFRContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mobileMoneyZMContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var  mpesaContentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var debitCardView: DebitCardView = {
        let view = DebitCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var ukViewContainer: UKAccountView = {
           let view = UKAccountView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    lazy var ukDetailsViewContainer: UKAccountDetailsView = {
           let view = UKAccountDetailsView()
           view.isHidden = true
           
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var pinViewContainer: PinView = {
        let view = PinView()
        view.isHidden = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var otpContentContainer: OTPView = {
        let view = OTPView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var accountOtpContentContainer: OTPView = {
           let view = OTPView()
           view.isHidden = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    lazy var mobileMoneyContentView: MobileMoneyGHView = {
        let view = MobileMoneyGHView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyPendingView: MobileMoneyGHPendingView = {
        let view = MobileMoneyGHPendingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mobileMoneyUgandaContentContainer: MobileMoneyUganda = {
        let view = MobileMoneyUganda()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyRWContentContainer: MobileMoneyRW = {
        let view = MobileMoneyRW()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyFRContentContainer: MobileMoneyFR = {
        let view = MobileMoneyFR()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mobileMoneyZMContentContainer: MobileMoneyZM = {
        let view = MobileMoneyZM()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mpesaView: MpesaView = {
        let view = MpesaView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mpesaBusinessView: MPesaBusinessView = {
        let view = MPesaBusinessView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mpesaPendingView: MpesaPendingView = {
        let view = MpesaPendingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var billingAddressContainer: BillingAddress = {
        let view = BillingAddress()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var saveCardContainer: SavedCardsView = {
        let view = SavedCardsView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectBankAccountView:SelectBankAccountView = {
        let view = SelectBankAccountView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let accountFormContainer:AccountForm = {
        let view = AccountForm()
        view.goBack.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let raveCardClient = RaveCardClient()
    let raveAccountClient = RaveAccountClient()
    let raveUKAccountClient = RaveAccountClient()
    let raveMpesaClient = RaveMpesaClient()
    let raveMobileMoney = RaveMobileMoneyClient()
    let raveMobileMoneyUganda = RaveMobileMoneyClient()
    let raveMobileMoneyRW = RaveMobileMoneyClient()
    let raveMobileMoneyFR = RaveMobileMoneyClient()
    let raveMobileMoneyZM = RaveMobileMoneyClient()
    public var amount:String?
    var saveCardTableController:SaveCardViewController!
    var savedCards:[SavedCard]?
    var bankPicker:UIPickerView!
    var ghsMobileMoneyPicker:UIPickerView!
    var zambiaMobileMoneyPicker:UIPickerView!
    var banks:[Bank]? = [] {
        didSet{
            bankPicker.reloadAllComponents()
        }
    }
     var selectedBankCode:String?
    override public func loadView() {
        super.loadView()
        IQKeyboardManager.shared.enable = true
        howCell.backgroundColor = .clear
        cardCell.backgroundColor = .clear
        mpesaCell.backgroundColor = .clear
        accountCell.backgroundColor = .clear
        ukAccountCell.backgroundColor = .clear
        mobileMoneyGH.backgroundColor = .clear
        mobileMoneyUG.backgroundColor = .clear
        mobileMoneyRW.backgroundColor = .clear
        mobileMoneyFR.backgroundColor = .clear
        mobileMoneyZM.backgroundColor = .clear
        
        ukAccountCell.contentView.addSubview(ukContentContainer)
        howCell.contentView.addSubview(howView)
        cardCell.contentView.addSubview(debitCardContentContainer)
        accountCell.contentView.addSubview(accountContentContainer)
        mpesaCell.contentView.addSubview(mpesaContentContainer)
        
        ukContentContainer.addSubview(ukViewContainer)
        ukContentContainer.addSubview(ukDetailsViewContainer)
        
        mobileMoneyRW.contentView.addSubview(mobileMoneyRWContainer)
        mobileMoneyFR.contentView.addSubview(mobileMoneyFRContainer)
        mobileMoneyRWContainer.addSubview(mobileMoneyRWContentContainer)
        mobileMoneyFRContainer.addSubview(mobileMoneyFRContentContainer)
        
        mobileMoneyZM.contentView.addSubview(mobileMoneyZMContainer)
        mobileMoneyZMContainer.addSubview(mobileMoneyZMContentContainer)
        
        debitCardContentContainer.addSubview(debitCardView)
        debitCardContentContainer.addSubview(pinViewContainer)
        debitCardContentContainer.addSubview(otpContentContainer)
        
        debitCardContentContainer.addSubview(billingAddressContainer)
        debitCardContentContainer.addSubview(saveCardContainer)
        
        accountContentContainer.addSubview(selectBankAccountView)
        accountContentContainer.addSubview(accountFormContainer)
        accountContentContainer.addSubview(accountOtpContentContainer)
       
        
        mpesaContentContainer.addSubview(mpesaView)
        mpesaContentContainer.addSubview(mpesaBusinessView)
        mpesaContentContainer.addSubview(mpesaPendingView)
        
        mobileMoneyGH.contentView.addSubview(mobileMoneyContainer)
        mobileMoneyContainer.addSubview(mobileMoneyContentView)
        mobileMoneyContainer.addSubview(mobileMoneyPendingView)
        
        mobileMoneyUG.contentView.addSubview(mobileMoneyUgandaContainer)
        mobileMoneyUgandaContainer.addSubview(mobileMoneyUgandaContentContainer)
        
        NSLayoutConstraint.activate([
            howView.leadingAnchor.constraint(equalTo: howCell.leadingAnchor),
            howView.trailingAnchor.constraint(equalTo: howCell.trailingAnchor),
            howView.topAnchor.constraint(equalTo: howCell.topAnchor),
            howView.bottomAnchor.constraint(equalTo: howCell.bottomAnchor),
            
            ukContentContainer.leadingAnchor.constraint(equalTo: ukAccountCell.leadingAnchor),
            ukContentContainer.trailingAnchor.constraint(equalTo: ukAccountCell.trailingAnchor),
            ukContentContainer.topAnchor.constraint(equalTo: ukAccountCell.topAnchor),
            ukContentContainer.bottomAnchor.constraint(equalTo: ukAccountCell.bottomAnchor),
            
            ukViewContainer.leadingAnchor.constraint(equalTo: ukContentContainer.leadingAnchor),
            ukViewContainer.trailingAnchor.constraint(equalTo: ukContentContainer.trailingAnchor),
            ukViewContainer.topAnchor.constraint(equalTo: ukContentContainer.topAnchor),
            ukViewContainer.bottomAnchor.constraint(equalTo: ukContentContainer.bottomAnchor),
            
            ukDetailsViewContainer.leadingAnchor.constraint(equalTo: ukContentContainer.leadingAnchor),
            ukDetailsViewContainer.trailingAnchor.constraint(equalTo: ukContentContainer.trailingAnchor),
            ukDetailsViewContainer.topAnchor.constraint(equalTo: ukContentContainer.topAnchor),
            ukDetailsViewContainer.bottomAnchor.constraint(equalTo: ukContentContainer.bottomAnchor),
            
            mobileMoneyRWContainer.leadingAnchor.constraint(equalTo: mobileMoneyRW.leadingAnchor),
            mobileMoneyRWContainer.trailingAnchor.constraint(equalTo: mobileMoneyRW.trailingAnchor),
            mobileMoneyRWContainer.topAnchor.constraint(equalTo: mobileMoneyRW.topAnchor),
            mobileMoneyRWContainer.bottomAnchor.constraint(equalTo: mobileMoneyRW.bottomAnchor),
            
            mobileMoneyFRContainer.leadingAnchor.constraint(equalTo: mobileMoneyFR.leadingAnchor),
            mobileMoneyFRContainer.trailingAnchor.constraint(equalTo: mobileMoneyFR.trailingAnchor),
            mobileMoneyFRContainer.topAnchor.constraint(equalTo: mobileMoneyFR.topAnchor),
            mobileMoneyFRContainer.bottomAnchor.constraint(equalTo: mobileMoneyFR.bottomAnchor),
            
            mobileMoneyZMContainer.leadingAnchor.constraint(equalTo: mobileMoneyZM.leadingAnchor),
            mobileMoneyZMContainer.trailingAnchor.constraint(equalTo: mobileMoneyZM.trailingAnchor),
            mobileMoneyZMContainer.topAnchor.constraint(equalTo: mobileMoneyZM.topAnchor),
            mobileMoneyZMContainer.bottomAnchor.constraint(equalTo: mobileMoneyZM.bottomAnchor),
            
            mobileMoneyRWContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyRWContainer.leadingAnchor),
            mobileMoneyRWContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyRWContainer.trailingAnchor),
            mobileMoneyRWContentContainer.topAnchor.constraint(equalTo: mobileMoneyRWContainer.topAnchor),
            mobileMoneyRWContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyRWContainer.bottomAnchor),
            
            mobileMoneyFRContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyFRContainer.leadingAnchor),
            mobileMoneyFRContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyFRContainer.trailingAnchor),
            mobileMoneyFRContentContainer.topAnchor.constraint(equalTo: mobileMoneyFRContainer.topAnchor),
            mobileMoneyFRContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyFRContainer.bottomAnchor),
            
            mobileMoneyZMContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyZMContainer.leadingAnchor),
            mobileMoneyZMContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyZMContainer.trailingAnchor),
            mobileMoneyZMContentContainer.topAnchor.constraint(equalTo: mobileMoneyZMContainer.topAnchor),
            mobileMoneyZMContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyZMContainer.bottomAnchor),
            
            accountContentContainer.leadingAnchor.constraint(equalTo: accountCell.leadingAnchor),
            accountContentContainer.trailingAnchor.constraint(equalTo: accountCell.trailingAnchor),
            accountContentContainer.topAnchor.constraint(equalTo: accountCell.topAnchor),
            accountContentContainer.bottomAnchor.constraint(equalTo: accountCell.bottomAnchor),
            
            selectBankAccountView.leadingAnchor.constraint(equalTo: accountContentContainer.leadingAnchor),
            selectBankAccountView.trailingAnchor.constraint(equalTo: accountContentContainer.trailingAnchor),
            selectBankAccountView.topAnchor.constraint(equalTo: accountContentContainer.topAnchor),
            selectBankAccountView.bottomAnchor.constraint(equalTo: accountContentContainer.bottomAnchor),
            
            accountFormContainer.leadingAnchor.constraint(equalTo: accountContentContainer.leadingAnchor),
            accountFormContainer.trailingAnchor.constraint(equalTo: accountContentContainer.trailingAnchor),
            accountFormContainer.topAnchor.constraint(equalTo: accountContentContainer.topAnchor),
            accountFormContainer.bottomAnchor.constraint(equalTo: accountContentContainer.bottomAnchor),
            
            mpesaContentContainer.leadingAnchor.constraint(equalTo: mpesaCell.leadingAnchor),
            mpesaContentContainer.trailingAnchor.constraint(equalTo: mpesaCell.trailingAnchor),
            mpesaContentContainer.topAnchor.constraint(equalTo: mpesaCell.topAnchor),
            mpesaContentContainer.bottomAnchor.constraint(equalTo: mpesaCell.bottomAnchor),
            
            mpesaView.leadingAnchor.constraint(equalTo: mpesaContentContainer.leadingAnchor),
            mpesaView.trailingAnchor.constraint(equalTo: mpesaContentContainer.trailingAnchor),
            mpesaView.topAnchor.constraint(equalTo: mpesaContentContainer.topAnchor),
            mpesaView.bottomAnchor.constraint(equalTo: mpesaContentContainer.bottomAnchor),
            
            mpesaBusinessView.leadingAnchor.constraint(equalTo: mpesaContentContainer.leadingAnchor),
            mpesaBusinessView.trailingAnchor.constraint(equalTo: mpesaContentContainer.trailingAnchor),
            mpesaBusinessView.topAnchor.constraint(equalTo: mpesaContentContainer.topAnchor),
            mpesaBusinessView.bottomAnchor.constraint(equalTo: mpesaContentContainer.bottomAnchor),
            
            mpesaPendingView.leadingAnchor.constraint(equalTo: mpesaContentContainer.leadingAnchor),
            mpesaPendingView.trailingAnchor.constraint(equalTo: mpesaContentContainer.trailingAnchor),
            mpesaPendingView.topAnchor.constraint(equalTo: mpesaContentContainer.topAnchor),
            mpesaPendingView.bottomAnchor.constraint(equalTo: mpesaContentContainer.bottomAnchor),
            
            debitCardContentContainer.leadingAnchor.constraint(equalTo: cardCell.leadingAnchor),
            debitCardContentContainer.trailingAnchor.constraint(equalTo: cardCell.trailingAnchor),
            debitCardContentContainer.topAnchor.constraint(equalTo: cardCell.topAnchor),
            debitCardContentContainer.bottomAnchor.constraint(equalTo: cardCell.bottomAnchor),
            
            debitCardView.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            debitCardView.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            debitCardView.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            debitCardView.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            saveCardContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            saveCardContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            saveCardContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            saveCardContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            billingAddressContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            billingAddressContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            billingAddressContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            billingAddressContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            pinViewContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            pinViewContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            pinViewContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            pinViewContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            otpContentContainer.leadingAnchor.constraint(equalTo: debitCardContentContainer.leadingAnchor),
            otpContentContainer.trailingAnchor.constraint(equalTo: debitCardContentContainer.trailingAnchor),
            otpContentContainer.topAnchor.constraint(equalTo: debitCardContentContainer.topAnchor),
            otpContentContainer.bottomAnchor.constraint(equalTo: debitCardContentContainer.bottomAnchor),
            
            accountOtpContentContainer.leadingAnchor.constraint(equalTo: accountContentContainer.leadingAnchor),
            accountOtpContentContainer.trailingAnchor.constraint(equalTo: accountContentContainer.trailingAnchor),
            accountOtpContentContainer.topAnchor.constraint(equalTo: accountContentContainer.topAnchor),
            accountOtpContentContainer.bottomAnchor.constraint(equalTo: accountContentContainer.bottomAnchor),
            
            mobileMoneyContainer.leadingAnchor.constraint(equalTo: mobileMoneyGH.leadingAnchor),
            mobileMoneyContainer.trailingAnchor.constraint(equalTo: mobileMoneyGH.trailingAnchor),
            mobileMoneyContainer.topAnchor.constraint(equalTo: mobileMoneyGH.topAnchor),
            mobileMoneyContainer.bottomAnchor.constraint(equalTo: mobileMoneyGH.bottomAnchor),
            
            mobileMoneyContentView.leadingAnchor.constraint(equalTo: mobileMoneyContainer.leadingAnchor),
            mobileMoneyContentView.trailingAnchor.constraint(equalTo: mobileMoneyContainer.trailingAnchor),
            mobileMoneyContentView.topAnchor.constraint(equalTo: mobileMoneyContainer.topAnchor),
            mobileMoneyContentView.bottomAnchor.constraint(equalTo: mobileMoneyContainer.bottomAnchor),
            
            mobileMoneyPendingView.leadingAnchor.constraint(equalTo: mobileMoneyContainer.leadingAnchor),
            mobileMoneyPendingView.trailingAnchor.constraint(equalTo: mobileMoneyContainer.trailingAnchor),
            mobileMoneyPendingView.topAnchor.constraint(equalTo: mobileMoneyContainer.topAnchor),
            mobileMoneyPendingView.bottomAnchor.constraint(equalTo: mobileMoneyContainer.bottomAnchor),
            
            mobileMoneyUgandaContainer.leadingAnchor.constraint(equalTo: mobileMoneyUG.leadingAnchor),
            mobileMoneyUgandaContainer.trailingAnchor.constraint(equalTo: mobileMoneyUG.trailingAnchor),
            mobileMoneyUgandaContainer.topAnchor.constraint(equalTo: mobileMoneyUG.topAnchor),
            mobileMoneyUgandaContainer.bottomAnchor.constraint(equalTo: mobileMoneyUG.bottomAnchor),
            
            mobileMoneyUgandaContentContainer.leadingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.leadingAnchor),
            mobileMoneyUgandaContentContainer.trailingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.trailingAnchor),
            mobileMoneyUgandaContentContainer.topAnchor.constraint(equalTo: mobileMoneyUgandaContainer.topAnchor),
            mobileMoneyUgandaContentContainer.bottomAnchor.constraint(equalTo: mobileMoneyUgandaContainer.bottomAnchor),
        ])
    }
    
    func modalSwipeDisabled(){
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        cardCallbacks()
        accountCallbacks()
        saveCardCallbacks()
        mpesaCallbacks()
        gbpAccountCallbacks()
        mobileMobileCallbacks()
        mobileMobileUgandaCallbacks()
        mobileMoneyRwandaCallbacks()
        mobileMoneyFrancoCallbacks()
        mobileMoneyZambiaCallbacks()
        modalSwipeDisabled()

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let navTitle = RavePayNavTitle(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        navTitle.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navTitle)
        
        let closeButton = UIButton(type: .system)
        closeButton.tintColor = .darkGray
        closeButton.setImage(UIImage(named: "rave_close", in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        closeButton.titleLabel?.font  = UIFont.systemFont(ofSize: 17, weight: .bold)
        closeButton.titleLabel?.textAlignment = .center
        closeButton.frame = CGRect(x: 0, y:0, width: 40, height: 40)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        self.tableView.backgroundColor = UIColor(hex: "#F2F2F2")
        self.tableView.tableFooterView = UIView(frame: .zero)
        configureView()
        configureDebitCardView()
        configureGBPView()
        configureBankView()
        configureOTPView()
        configureMpesaView()
        configureMobileMoney()
        configureMobileMoneyUganda()
        configureMobileMoneyRwanda()
        configureMobileMoneyFranco()
        configureMobileMoneyZambia()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        debitCardView.frame = debitCardContentContainer.frame
    }
    
    func configureView(){
        
        let debitCardHeader = getHeader()
        let bankAccountHeader = getHeader()
        let mpesaHeader = getHeader()
        let ghanaMobileMoneyHeader = getHeader()
        let ugandaMobileMoneyHeader = getHeader()
        let rwandaMobileMoneyHeader = getHeader()
        let francoMobileMoneyHeader = getHeader()
        let zambiaMobileMoneyHeader = getHeader()
        let ukMobileMoneyHeader = getHeader()
        headers = [nil,debitCardHeader,bankAccountHeader, mpesaHeader,ghanaMobileMoneyHeader,ugandaMobileMoneyHeader,rwandaMobileMoneyHeader,francoMobileMoneyHeader,zambiaMobileMoneyHeader,ukMobileMoneyHeader]
        raveAccountClient.getBanks()
    }
    
   
    func configureDebitCardView(){
        

          debitCardView.cardNumberTextField.delegate = self
          debitCardView.cardNumberTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        debitCardView.cardExpiry.delegate = self
         debitCardView.cardCVV.delegate = self
         debitCardView.cardPayButton.addTarget(self, action: #selector(cardPayButtonTapped), for: .touchUpInside)
         debitCardView.cardPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)

         saveCardContainer.useAnotherCardButton.addTarget(self, action: #selector(showDebitCardView), for: .touchUpInside)
        debitCardView.rememberCardCheck.addTarget(self, action: #selector(toggleSaveCardCheck), for: .touchUpInside)
        debitCardView.rememberCardText.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(toggleSaveCardCheck)))
        debitCardView.rememberCardText.isUserInteractionEnabled = true

        saveCardTableController = SaveCardViewController()
        saveCardTableController.delegate = self
        self.addChild(saveCardTableController)
        self.saveCardContainer.savedCardTableContainer.addSubview(saveCardTableController.view)
        saveCardTableController.view.frame = self.saveCardContainer.savedCardTableContainer.frame
        saveCardTableController.view.clipsToBounds = true
        saveCardTableController.didMove(toParent: self)

        pinViewContainer.hiddenPinTextField.delegate = self
        pinViewContainer.hiddenPinTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        pinViewContainer.pinContinueButton.layer.cornerRadius = 5
        pinViewContainer.pinContinueButton.addTarget(self, action: #selector(pinContinueButtonTapped), for: .touchUpInside)
        for _view in pinViewContainer.pins{
            _view.layer.cornerRadius = 3
            _view.isUserInteractionEnabled = true
            _view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPinKeyboard)))
        }
        
          billingAddressContainer.billingAddressTextField.delegate = self

          billingAddressContainer.stateTextField.delegate = self

          billingAddressContainer.cityTextField.delegate = self
          billingAddressContainer.countryTextField.delegate = self

          billingAddressContainer.zipCodeTextField.delegate = self
           billingAddressContainer.billingContinueButton.addTarget(self, action: #selector(billAddressButtonTapped), for: .touchUpInside)
    }
    
    func configureBankView(){
       
        //access - 044 , sterling - 232 , zenith - 057, providus -101
        let dropButton = UIButton(type: .custom)
        dropButton.frame = CGRect(x: 0, y: 0, width: self.selectBankAccountView.otherBanksTextField.frame.height, height: selectBankAccountView.otherBanksTextField.frame.height)
        dropButton.setImage(UIImage(named: "rave_down_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        dropButton.addTarget(self, action: #selector(selectBankArrowTapped), for: .touchUpInside)
        self.selectBankAccountView.otherBanksTextField.rightView =  dropButton
        self.selectBankAccountView.otherBanksTextField.rightViewMode = .always
        bankPicker = UIPickerView()
        bankPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        bankPicker.showsSelectionIndicator = true
        bankPicker.delegate = self
        bankPicker.dataSource = self
        bankPicker.tag = 12
        self.selectBankAccountView.otherBanksTextField.delegate = self
        
        self.selectBankAccountView.otherBanksTextField.inputView = bankPicker
        

       let dp = UIDatePicker()
        dp.datePickerMode = .date
        accountFormContainer.dobTextField.inputView = dp
        dp.addTarget(self, action: #selector(dobPickerValueChanged), for: .valueChanged)


       accountFormContainer.accountPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
       accountFormContainer.accountPayButton.addTarget(self, action: #selector(accountPayButtonTapped), for: .touchUpInside)
        
        
        raveAccountClient.amount = self.amount
        raveAccountClient.getFee()
    
        
    }
    func configureOTPView(){

        self.otpContentContainer.otpButton.addTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
    }
    func configureMpesaView(){
        raveMpesaClient.transactionReference = RaveConfig.sharedConfig().transcationRef
        
        
        
        mpesaView.mpesaPayButton.layer.cornerRadius = 5
        mpesaView.mpesaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mpesaView.mpesaPayButton.addTarget(self, action: #selector(mpesaPayButtonTapped), for: .touchUpInside)
        
        raveMpesaClient.amount = self.amount
        raveMpesaClient.email = RaveConfig.sharedConfig().email
        raveMpesaClient.getFee()
    }
    
    //MARK: MPESA Payment
    @objc func mpesaPayButtonTapped(){
        self.mpesaPayAction()
    }
    
    func mpesaPayAction(){
        guard let number = mpesaView.mpesaPhoneNumber.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMpesaClient.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMpesaClient.chargeMpesa()
    }
    func configureGBPView(){
           raveUKAccountClient.amount = amount
           raveUKAccountClient.getFee()
           
        ukViewContainer.accountPayButton.layer.cornerRadius = 5
        ukViewContainer.accountPayButton.addTarget(self, action: #selector(chargeGBPAccountFlow), for: .touchUpInside)
        ukDetailsViewContainer.accountContinueButton.layer.cornerRadius = 5
        ukDetailsViewContainer.accountContinueButton.addTarget(self, action: #selector(completeGBPAccountFlow), for: .touchUpInside)
       }
    
    func configureMobileMoney(){
        raveMobileMoney.transactionReference = RaveConfig.sharedConfig().transcationRef
//        mobileMoneyContainer.addSubview(mobileMoneyContentView)
//        mobileMoneyContainer.addSubview(mobileMoneyPendingView)
//        mobileMoneyPendingView.isHidden = true
        ghsMobileMoneyPicker = UIPickerView()
        ghsMobileMoneyPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        ghsMobileMoneyPicker.showsSelectionIndicator = true
        ghsMobileMoneyPicker.delegate = self
        ghsMobileMoneyPicker.dataSource = self
        ghsMobileMoneyPicker.tag = 13
        self.mobileMoneyContentView.mobileMoneyChooseNetwork.delegate = self
       
        self.mobileMoneyContentView.mobileMoneyChooseNetwork.inputView = ghsMobileMoneyPicker
        mobileMoneyContentView.mobileMoneyChooseNetwork.layer.cornerRadius = 5
        
        mobileMoneyContentView.mobileMoneyPhoneNumber.layer.cornerRadius = 5
        
        mobileMoneyContentView.mobileMoneyVoucher.layer.cornerRadius = 5
        
        mobileMoneyContentView.mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyContentView.mobileMoneyPay.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyContentView.mobileMoneyPay.addTarget(self, action: #selector(mobileMoneyPayAction), for: .touchUpInside)
        
        raveMobileMoney.amount = self.amount
        raveMobileMoney.email = RaveConfig.sharedConfig().email
        raveMobileMoney.getFee()
    }
    
    func configureMobileMoneyUganda(){
        raveMobileMoneyUganda.transactionReference = RaveConfig.sharedConfig().transcationRef
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPhone.layer.cornerRadius = 5
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton.layer.cornerRadius = 5
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton.addTarget(self, action: #selector(mobileMoneyUgandaPayAction), for: .touchUpInside)
        
        raveMobileMoneyUganda.amount = self.amount
        raveMobileMoneyUganda.email = RaveConfig.sharedConfig().email
        raveMobileMoneyUganda.getFee()
    }
    
    func configureMobileMoneyZambia(){
        raveMobileMoneyZM.transactionReference = RaveConfig.sharedConfig().transcationRef
        mobileMoneyZMContentContainer.mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyZMContentContainer.mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyZMContentContainer.mobileMoneyPay.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyZMContentContainer.mobileMoneyPay.addTarget(self, action: #selector(mobileMoneyZambiaPayAction), for: .touchUpInside)
        
         zambiaMobileMoneyPicker = UIPickerView()
         zambiaMobileMoneyPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
         zambiaMobileMoneyPicker.showsSelectionIndicator = true
         zambiaMobileMoneyPicker.delegate = self
         zambiaMobileMoneyPicker.dataSource = self
         zambiaMobileMoneyPicker.tag = 17
         self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.delegate = self
        
         self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.inputView = zambiaMobileMoneyPicker
         mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.layer.cornerRadius = 5
        
        raveMobileMoneyZM.amount = self.amount
        raveMobileMoneyZM.email = RaveConfig.sharedConfig().email
        raveMobileMoneyZM.getFee()
    }
    
    func configureMobileMoneyFranco(){
        raveMobileMoneyFR.transactionReference = RaveConfig.sharedConfig().transcationRef
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.layer.cornerRadius = 5
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.layer.cornerRadius = 5
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyFRContentContainer.mobileMoneyFRPayButton.addTarget(self, action: #selector(mobileMoneyFrancoPayAction), for: .touchUpInside)
        
        raveMobileMoneyFR.amount = self.amount
        raveMobileMoneyFR.email = RaveConfig.sharedConfig().email
        raveMobileMoneyFR.getFee()
    }
    
    func configureMobileMoneyRwanda(){
        raveMobileMoneyRW.transactionReference = RaveConfig.sharedConfig().transcationRef
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.layer.cornerRadius = 5
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.layer.cornerRadius = 5
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyRWContentContainer.mobileMoneyRWPayButton.addTarget(self, action: #selector(mobileMoneyRwandaPayAction), for: .touchUpInside)
        raveMobileMoneyRW.amount = self.amount
        raveMobileMoneyRW.email = RaveConfig.sharedConfig().email
        raveMobileMoneyRW.getFee()
    }
    @objc func chargeGBPAccountFlow(){
        self.view.endEditing(true)
        if RaveConfig.sharedConfig().currencyCode == .some("GBP"){
            LoadingHUD.shared().show()
            raveUKAccountClient.amount = self.amount
            raveUKAccountClient.accountNumber = "00000"
            raveUKAccountClient.bankCode = "093"
            raveUKAccountClient.phoneNumber = RaveConfig.sharedConfig().phoneNumber
            raveUKAccountClient.chargeAccount()
        }
    }
    @objc func completeGBPAccountFlow(){
           self.view.endEditing(true)
           if RaveConfig.sharedConfig().currencyCode == .some("GBP"){
               LoadingHUD.shared().show()
               raveUKAccountClient.queryTransaction(txRef: raveUKAccountClient.txRef)
           }
       }
    
    @objc func mobileMoneyPayAction(){
        guard let number = mobileMoneyContentView.mobileMoneyPhoneNumber.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMobileMoney.network = mobileMoneyContentView.mobileMoneyChooseNetwork.text
        raveMobileMoney.voucher = mobileMoneyContentView.mobileMoneyVoucher.text
        raveMobileMoney.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoney.chargeMobileMoney()
    }
    
    @objc func mobileMoneyUgandaPayAction(){
        guard let number = mobileMoneyUgandaContentContainer.mobileMoneyUgandaPhone.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMobileMoneyUganda.mobileMoneyType = .uganda
        raveMobileMoneyUganda.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoneyUganda.chargeMobileMoney(.uganda)
    }
    
    @objc func mobileMoneyRwandaPayAction(){
        guard let number = mobileMoneyRWContentContainer.mobileMoneyRWPhone.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMobileMoneyRW.mobileMoneyType = .rwanda
        raveMobileMoneyRW.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoneyRW.chargeMobileMoney(.rwanda)
    }
    
    @objc func mobileMoneyFrancoPayAction(){
        guard let number = mobileMoneyFRContentContainer.mobileMoneyFRPhone.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveMobileMoneyFR.mobileMoneyType = .franco
        raveMobileMoneyFR.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoneyFR.chargeMobileMoney(.franco)
    }
    
    @objc func mobileMoneyZambiaPayAction(){
        guard let number = mobileMoneyZMContentContainer.mobileMoneyPhoneNumber.text , number != "" else{
            return
        }
        self.view.endEditing(true)
        LoadingHUD.shared().show()
		raveMobileMoneyZM.network = mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.text
        raveMobileMoneyZM.mobileMoneyType = .zambia
        raveMobileMoneyZM.phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveMobileMoneyZM.chargeMobileMoney(.zambia)
    }
    
    @objc func dobPickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.accountFormContainer.dobTextField.text = selectedDate
    }
    
    @objc func accountPayButtonTapped(){
        self.accountPayAction()
    }
    func accountPayAction(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveAccountClient.accountNumber = accountFormContainer.accountNumberTextField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        raveAccountClient.phoneNumber = accountFormContainer.phoneNumberTextField.text
        raveAccountClient.amount = self.amount
        raveAccountClient.bankCode = selectedBankCode
        if let passcode = self.accountFormContainer.dobTextField.text , passcode != "" {
            raveAccountClient.passcode = passcode
        }
        if let bvn = self.accountFormContainer.accountBvn.text , bvn != "" {
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
    @objc func selectBankArrowTapped(){
        self.selectBankAccountView.otherBanksTextField.becomeFirstResponder()
    }
    
    @objc func showPinKeyboard(){
        self.pinViewContainer.hiddenPinTextField.becomeFirstResponder()
    }
    
    @objc func toggleSaveCardCheck(){
        raveCardClient.saveCard =  !raveCardClient.saveCard
        let image =  raveCardClient.saveCard == true ? UIImage(named:"rave_check_box",in: Bundle.getResourcesBundle(), compatibleWith: nil) :  UIImage(named:"rave_unchecked_box",in: Bundle.getResourcesBundle(), compatibleWith: nil)
        debitCardView.rememberCardCheck.setImage(image, for: .normal)
    }

    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         return expandables.count
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return expandables[section].isExpanded ? 1 : 0
    }

 
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            howCell.selectionStyle = .none
            return  howCell
        case 1:
            cardCell.selectionStyle = .none
            return cardCell
        case 2:
            accountCell.selectionStyle = .none
            return accountCell
        case 3:
            mpesaCell.selectionStyle = .none
            return mpesaCell
        case 4:
            mobileMoneyGH.selectionStyle = .none
            return mobileMoneyGH
        case 5:
            mobileMoneyUG.selectionStyle = .none
            return mobileMoneyUG
        case 6:
            mobileMoneyRW.selectionStyle = .none
            return mobileMoneyRW
        case 7:
            mobileMoneyFR.selectionStyle = .none
            return mobileMoneyFR
        case 8:
            mobileMoneyZM.selectionStyle = .none
            return mobileMoneyZM
        case 9:
            ukAccountCell.selectionStyle = .none
           return ukAccountCell
        default:
             fatalError("Unknown row in section 0")
        }
    }
   
    func checkIfPaymentOptionIsExcluded(paymentOption:PaymentOption) -> Bool{
        return RaveConfig.sharedConfig().paymentOptionsToExclude.filter{ currentPaymentOption in
            currentPaymentOption == paymentOption
        }.count > 0
    }
    
    override  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
             return 0
        case 1:
            //||  RaveConfig.sharedConfig().country == "UG"
            return RaveConfig.sharedConfig().currencyCode == "" || RaveConfig.sharedConfig().country == "GHS" || checkIfPaymentOptionIsExcluded(paymentOption: .debitCard) ? 0 :  65
        case 2:
            return (RaveConfig.sharedConfig().currencyCode == "NGN" || RaveConfig.sharedConfig().currencyCode == "USD" || RaveConfig.sharedConfig().currencyCode == "ZAR") && !checkIfPaymentOptionIsExcluded(paymentOption: .bankAccount) ? 65 : 0
        case 3:
            return RaveConfig.sharedConfig().currencyCode == "KES" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 4:
            return RaveConfig.sharedConfig().currencyCode == "GHS" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ?  65 : 0
        case 5:
            return RaveConfig.sharedConfig().currencyCode == "UGX" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 6:
            return RaveConfig.sharedConfig().currencyCode == "RWF" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 7:
           // return RaveConfig.sharedConfig().currencyCode == "XAF" || RaveConfig.sharedConfig().currencyCode == "XOF" ? 65 : 0
            return 0
        case 8:
            return RaveConfig.sharedConfig().currencyCode == "ZMW" && !checkIfPaymentOptionIsExcluded(paymentOption: .mobileMoney) ? 65 : 0
        case 9:
            return RaveConfig.sharedConfig().currencyCode == "GBP" && !checkIfPaymentOptionIsExcluded(paymentOption: .bankAccount) ? 65 : 0
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
        case 6:
            let headerTitle = "Pay with Mobile Money Rwanda"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Rwanda")!, in: headerTitle))
            headers[6]?.titleLabel.attributedText = attributedString
            headers[6]?.arrowButton.tag = 6
            headers[6]?.button.tag = 6
            return headers[6]
        case 7:
            let headerTitle = "Pay with Mobile Money Francophone"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Francophone")!, in: headerTitle))
            headers[7]?.titleLabel.attributedText = attributedString
            headers[7]?.arrowButton.tag = 7
            headers[7]?.button.tag = 7
            return headers[7]
        case 8:
            let headerTitle = "Pay with Mobile Money Zambia"
            let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: "Mobile Money Zambia")!, in: headerTitle))
            headers[8]?.titleLabel.attributedText = attributedString
            headers[8]?.arrowButton.tag = 8
            headers[8]?.button.tag = 8
            return headers[8]
            
        case 9:
               let headerTitle = "Pay with your Bank Account"
               let attributedString = NSMutableAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor(hex: "#4A4A4A")])
               attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range:NSRange(headerTitle.range(of: " Bank Account")!, in: headerTitle))
               headers[9]?.titleLabel.attributedText = attributedString
               headers[9]?.arrowButton.tag = 9
               headers[9]?.button.tag = 9
               return headers[9]
            
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
               case 6:
                   return expandables[indexPath.section].isExpanded ? 400 : 0
               case 7:
                   return expandables[indexPath.section].isExpanded ? 400 : 0
               case 8:
                   return expandables[indexPath.section].isExpanded ? 400 : 0
                   case 9:
                   return expandables[indexPath.section].isExpanded ? 400 : 0
               default:
                   return expandables[indexPath.section].isExpanded ? self.view.frame.height - (200 + navBarHeight) : 0
               }
        
    }
    
    func getHeader()-> RavePayHeaderView{
        let header = RavePayHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65))
        header.backgroundColor = UIColor(hex: "#FBEED8")
        header.button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        return header
    }
    @objc func handleButtonTap(_ sender:UIButton){
        self.handelCloseOrExpandSection(section: sender.tag)
    }
    func handelCloseOrExpandSection(section:Int){
        let expandedState = expandables[section].isExpanded
        if expandedState{
            //Collapse the expanded state and expaand the first section
            expandables[0].isExpanded = true
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            expandables[section].isExpanded = false
            self.tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .fade)
            self.headers[section]?.arrowButton.setImage(UIImage(named: "rave_up_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        }else{
            //Expand current view and collapse the other sections
            var expandedIndexPath = [IndexPath]()
            var newExpandables = [Expandables]()
            for item in self.expandables{
                if item.isExpanded == true{
                    expandedIndexPath.append(IndexPath(row: 0, section: item.section))
                    self.headers[section]?.arrowButton.setImage(UIImage(named: "rave_up_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
                }
            }
            
            for item in self.expandables{
                newExpandables.append(Expandables(isExpanded: false, section: item.section))
                self.headers[item.section]?.arrowButton.setImage(UIImage(named: "rave_up_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
            }
            self.expandables = newExpandables
            
            
            self.tableView.deleteRows(at: expandedIndexPath, with: .fade)
            //expandables[0].isExpanded = false
            
            
            self.expandables[section].isExpanded = true
            self.headers[section]?.arrowButton.setImage(UIImage(named: "rave_down_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: section)], with: .fade)
            //Check if selected tab is Bank Account and Country is US
            if section == 2{
                self.chargeUSAccountFlow()
                self.chargeSAAccountFlow()
            }
        }
    }
    
    
    @objc func closeView(){
            self.view.endEditing(true)
            self.delegate?.onDismiss()
            self.dismiss(animated: true)
        }

    @objc func cardPayButtonTapped(){
        guard let cardNumber = self.debitCardView.cardNumberTextField.text, cardNumber != "" else
        {
            self.debitCardView.cardNumberTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.debitCardView.cardNumberTextField.layer.borderWidth = 0.5
            return  }
        guard let expiry = self.debitCardView.cardExpiry.text, expiry != "" else
        {
            self.debitCardView.cardExpiry.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.debitCardView.cardExpiry.layer.borderWidth = 0.5
            return
            
        }
        guard let cvv = self.debitCardView.cardCVV.text, cvv != "" else
        {
            self.debitCardView.cardCVV.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.debitCardView.cardCVV.layer.borderWidth = 0.5
            return
            
        }
        self.cardPayAction()
        
    }
    func saveCardCallbacks(){
        if let _ = RaveConfig.sharedConfig().publicKey{
            if let deviceNumber = RaveConfig.sharedConfig().phoneNumber, deviceNumber != ""{
               // LoadingHUD.shared().showInView(view: self.view)
                 LoadingHUD.shared().show()
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
    
    func gbpAccountCallbacks(){
              raveUKAccountClient.transactionReference = RaveConfig.sharedConfig().transcationRef
              raveUKAccountClient.feeSuccess = {[weak self](fee, chargeAmount) in
                  if let amount = chargeAmount, amount != "" {
                      DispatchQueue.main.async {
                       self?.ukViewContainer.accountPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                      }
                  }
              }
              
              raveUKAccountClient.chargeSuccess = {[weak self](flwRef,data) in
                   LoadingHUD.shared().hide()
                  self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
                  self?.dismiss(animated: true)
              }
              
              raveUKAccountClient.chargeGBPOTPAuth =  {[weak self](flwRef, reference,message) in
                   LoadingHUD.shared().hide()
                  self?.showGBPBankDetails(reference)
              }
              
              raveUKAccountClient.redoChargeOTPAuth =  {[weak self](flwRef, message) in
                   LoadingHUD.shared().hide()
                  self?.showOTP(message: message, flwRef: flwRef, otpType: .bank)
              }
              
              raveUKAccountClient.chargeWebAuth = {[weak self](flwRef, authURL) in
                   LoadingHUD.shared().hide()
                  self?.showWebView(url: authURL,ref:flwRef)
              }
              raveUKAccountClient.validateError = {[weak self](message,data) in
                   LoadingHUD.shared().hide()
                  //Still show success
                  if let _data  = data{
                      let flwref = _data["flwRef"] as? String
                      self?.delegate?.tranasctionSuccessful(flwRef: flwref,responseData: data)
                  }else{
                      if (message?.containsIgnoringCase(find: "Timed Out"))!{
                         self?.delegate?.tranasctionSuccessful(flwRef: nil, responseData: data)
                      }else{
                          self?.delegate?.tranasctionFailed(flwRef: nil, responseData:  data)
                      }
                  }
                  self?.dismiss(animated: true)
              }
              raveUKAccountClient.error = {(message,data) in
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
    
    func showGBPBankDetails(_ reference:String){
        ukDetailsViewContainer.isHidden = false
        ukDetailsViewContainer.alpha = 0
        
        ukDetailsViewContainer.amountValue.text = raveUKAccountClient.chargeAmount?.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode)
        ukDetailsViewContainer.accountNumberValue.text = "43271228"
        ukDetailsViewContainer.sortCodeValue.text = "04-00-53"
        ukDetailsViewContainer.referenceNumberValue.text = reference
        UIView.animate(withDuration: 0.6, animations: {
            self.ukDetailsViewContainer.alpha = 1
            self.ukViewContainer.alpha = 0
        }) { (completed) in
            self.ukViewContainer.isHidden = true
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
                    self?.accountFormContainer.accountPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveAccountClient.chargeSuccess = {[weak self](flwRef,data) in
            LoadingHUD.shared().hide()
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
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
                self?.delegate?.tranasctionSuccessful(flwRef: flwref,responseData: data)
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
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        raveCardClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.debitCardView.cardPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
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
                self?.delegate?.tranasctionSuccessful(flwRef: flwref,responseData: data)
            }else{
                if (message?.containsIgnoringCase(find: "Timed Out"))!{
                    self?.delegate?.tranasctionSuccessful(flwRef: nil,responseData: data)
                }else{
                    self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                }
            }
            self?.dismiss(animated: true)
        }
        
    }
    
    func mpesaCallbacks(){
        raveMpesaClient.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mpesaView.mpesaPayButton.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
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
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        raveMpesaClient.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
        
    }
    
    func showMpesaPending(mesage:String){
        mpesaPendingView.isHidden = false
        mpesaPendingView.alpha = 0
        mpesaPendingView.mpesaPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mpesaPendingView.alpha = 1
            self.mpesaView.alpha = 0
        }) { (completed) in
            self.mpesaView.isHidden = true
            
        }
    }
    @objc func showMpesaPendingNoNotificaction(){
        self.mpesaPendingView.mpesaPendingNoNotification.isHidden = false
        self.mpesaPendingView.mpesaPendingNoNotification.isUserInteractionEnabled = true
        self.mpesaPendingView.mpesaPendingNoNotification.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMpesaBusinessView)))
    }
    @objc func showMpesaBusinessView(){
        mpesaBusinessView.isHidden = false
        mpesaBusinessView.alpha = 0
        mpesaBusinessView.mpesaBusinessNumber.text = raveMpesaClient.businessNumber
        mpesaBusinessView.mpesaAccountNumber.text = raveMpesaClient.accountNumber
        UIView.animate(withDuration: 0.6, animations: {
            self.mpesaBusinessView.alpha = 1
            self.mpesaPendingView.alpha = 0
        }) { (completed) in
            self.mpesaPendingView.isHidden = true
            
        }
    }
    func mobileMoneyZambiaCallbacks(){
        raveMobileMoneyZM.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mobileMoneyZMContentContainer.mobileMoneyPay.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveMobileMoneyZM.chargePending = {[weak self] (title,message) in
           
            DispatchQueue.main.async {
                 LoadingHUD.shared().hide()
                self?.showMobileMoneyPendingZM(mesage: message ?? "")
            }
            
        }
        raveMobileMoneyZM.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared().hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        raveMobileMoneyZM.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        raveMobileMoneyZM.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
    }
    func mobileMoneyFrancoCallbacks(){
        raveMobileMoneyFR.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mobileMoneyFRContentContainer.mobileMoneyFRPayButton .setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveMobileMoneyFR.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                
                self?.showMobileMoneyPendingFR(mesage: message ?? "")
            }
            
        }
        raveMobileMoneyFR.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared().hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        raveMobileMoneyFR.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        raveMobileMoneyFR.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
    }
    
    func mobileMoneyRwandaCallbacks(){
        raveMobileMoneyRW.feeSuccess = {[weak self](fee, chargeAmount) in
            if let amount = chargeAmount, amount != "" {
                DispatchQueue.main.async {
                    self?.mobileMoneyRWContentContainer.mobileMoneyRWPayButton .setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        raveMobileMoneyRW.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared().hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        raveMobileMoneyRW.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                
                self?.showMobileMoneyPendingRW(mesage: message ?? "")
            }
            
        }
        raveMobileMoneyRW.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        raveMobileMoneyRW.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
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
                    self?.mobileMoneyUgandaContentContainer.mobileMoneyUgandaPayButton .setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                }
            }
        }
        
        raveMobileMoneyUganda.chargeWebAuth = {[weak self](flwRef, authURL) in
            LoadingHUD.shared().hide()
            self?.showWebView(url: authURL,ref:flwRef)
        }
        
        raveMobileMoneyUganda.chargePending = {[weak self] (title,message) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                
                self?.showMobileMoneyPendingUG(mesage: message ?? "")
            }
            
        }
        raveMobileMoneyUganda.chargeSuccess = {[weak self](flwRef,data) in
            self?.delegate?.tranasctionSuccessful(flwRef: flwRef,responseData: data)
            self?.dismiss(animated: true)
        }
        raveMobileMoneyUganda.error = {[weak self](message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timeout"){
                        showSnackBarWithMessage(msg:  message ?? "The request timed out", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }else{
                        showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                            self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                            self?.dismiss(animated: true)
                        })
                    }
                }
            }
        }
        
    }
    func showMobileMoneyPendingZM(mesage:String) {
        mobileMoneyZMContainer.addSubview(mobileMoneyPendingView)
		NSLayoutConstraint.activate([
			mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyZMContainer.leadingAnchor, constant:20),
			mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyZMContainer.topAnchor, constant:71),
			mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyZMContainer.trailingAnchor, constant:-20),
		])
        mobileMoneyPendingView.frame = mobileMoneyZMContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyZMContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyZMContentContainer.isHidden = true
        }
    }
    func showMobileMoneyPendingFR(mesage:String){
        mobileMoneyFRContainer.addSubview(mobileMoneyPendingView)
		NSLayoutConstraint.activate([
			mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyFRContainer.leadingAnchor, constant:20),
			mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyFRContainer.topAnchor, constant:71),
			mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyFRContainer.trailingAnchor, constant:-20),
		])
        mobileMoneyPendingView.frame = mobileMoneyFRContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyFRContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyFRContentContainer.isHidden = true
            
        }
    }
    func showMobileMoneyPendingRW(mesage:String){
        mobileMoneyRWContainer.addSubview(mobileMoneyPendingView)
		NSLayoutConstraint.activate([
			mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyRWContainer.leadingAnchor, constant:20),
			mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyRWContainer.topAnchor, constant:71),
			mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyRWContainer.trailingAnchor, constant:-20),
		])
        mobileMoneyPendingView.frame = mobileMoneyRWContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyRWContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyRWContentContainer.isHidden = true
            
        }
    }
    
    func showMobileMoneyPendingUG(mesage:String){
        mobileMoneyUgandaContainer.addSubview(mobileMoneyPendingView)
		NSLayoutConstraint.activate([
			mobileMoneyPendingView.mobileMoneyPendingLabel.leadingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.leadingAnchor, constant:20),
			mobileMoneyPendingView.mobileMoneyPendingLabel.topAnchor.constraint(equalTo: mobileMoneyUgandaContainer.topAnchor, constant:71),
			mobileMoneyPendingView.mobileMoneyPendingLabel.trailingAnchor.constraint(equalTo: mobileMoneyUgandaContainer.trailingAnchor, constant:-20),
		])
        mobileMoneyPendingView.frame = mobileMoneyUgandaContainer.frame
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyUgandaContentContainer.alpha = 0
        }) { (completed) in
            self.mobileMoneyUgandaContentContainer.isHidden = true
            
        }
    }
    func showMobileMoneyPending(mesage:String){
        mobileMoneyPendingView.isHidden = false
        mobileMoneyPendingView.alpha = 0
        mobileMoneyPendingView.mobileMoneyPendingLabel.text = mesage
        UIView.animate(withDuration: 0.6, animations: {
            self.mobileMoneyPendingView.alpha = 1
            self.mobileMoneyContentView.alpha = 0
        }) { (completed) in
            self.mobileMoneyContentView.isHidden = true
            
        }
    }

    func mobileMobileCallbacks(){
            raveMobileMoney.feeSuccess = {[weak self](fee, chargeAmount) in
                if let amount = chargeAmount, amount != "" {
                    DispatchQueue.main.async {
                        self?.mobileMoneyContentView.mobileMoneyPay.setTitle("Pay \(amount.toCountryCurrency(code: RaveConfig.sharedConfig().currencyCode) )", for: .normal)
                    }
                }
            }
            
            raveMobileMoney.chargeWebAuth = {[weak self](flwRef, authURL) in
                LoadingHUD.shared().hide()
                self?.showWebView(url: authURL,ref:flwRef)
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
                                self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                                self?.dismiss(animated: true)
                            })
                        }else{
                            showSnackBarWithMessage(msg:  message ?? "An error occurred", style: .error, autoComplete: true, completion: {
                                self?.delegate?.tranasctionFailed(flwRef: nil,responseData: data)
                                self?.dismiss(animated: true)
                            })
                        }
                    }
                }
            }
            
        }
    
    func cardPayAction(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        raveCardClient.cardNumber = self.debitCardView.cardNumberTextField.text?.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
        raveCardClient.cvv = self.debitCardView.cardCVV.text
        raveCardClient.expYear = String(self.debitCardView.cardExpiry.text.dropFirst(2))
        raveCardClient.expMonth = String(self.debitCardView.cardExpiry.text.prefix(2))
        raveCardClient.amount = self.amount
        raveCardClient.chargeCard()
       
        
    }
    

}
@available(iOS 11.0, *)
extension NewRavePayViewController : UITextFieldDelegate,CardSelect,UIPickerViewDelegate,UIPickerViewDataSource,RavePayWebProtocol{
    func tranasctionSuccessful(flwRef: String, responseData:[String:Any]?) {
        self.dismiss(animated: true) {
            self.delegate?.tranasctionSuccessful(flwRef: flwRef, responseData: responseData)
        }
    }
    
    func cardSelected(card: SavedCard?) {
        raveCardClient.selectedCard = card
        if let card =  raveCardClient.selectedCard{
            LoadingHUD.shared().show()

            raveCardClient.sendOTP(card: card)
        }
    }
    @objc func textFieldDidChange(textField: UITextField) {
        if (textField == pinViewContainer.hiddenPinTextField){
            pinViewContainer.pins.forEach { (item) in
                item.backgroundColor = .white
            }
            
            for (index,_) in (textField.text?.enumerated())!{
                pinViewContainer.pins[index].backgroundColor = .gray
            }
            if ((textField.text?.count)! == 4){
                textField.resignFirstResponder()
            }
            
        }
        if (textField == debitCardView.cardNumberTextField){
            if let count = textField.text?.count {
                if count == 6{
                    raveCardClient.amount = self.amount
                    raveCardClient.cardfirst6 = textField.text
                    raveCardClient.getFee()
                }
            }
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        if textField == selectBankAccountView.otherBanksTextField{
            if let count = self.banks?.count, count > 0{
                bankPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(bankPicker, didSelectRow: 0, inComponent: 0)
            }
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == selectBankAccountView.otherBanksTextField {
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
    func showAccountFormScreen(withBackGround backgroundColor:String = "#f2f2f2", imageName:String = "", dobFieldHidden:Bool = true, bvnFieldHidden:Bool = true ){
        accountFormContainer.isHidden = false
        accountFormContainer.alpha = 0
        //selectBankAccountView
        UIView.animate(withDuration: 0.6, animations: {
            self.accountFormContainer.alpha = 1
            self.accountFormContainer.backgroundColor = UIColor(hex: "#f2f2f2")
            self.accountFormContainer.accountImageView.image = UIImage(named: imageName,in: Bundle.getResourcesBundle(), compatibleWith: nil)
            self.accountFormContainer.dobTextField.isHidden = dobFieldHidden
            self.accountFormContainer.accountBvn.isHidden = bvnFieldHidden
            self.selectBankAccountView.alpha = 0
        }) { (succeeded) in
            self.selectBankAccountView.isHidden = true
        }
    }
    
    @objc func goBackButtonTapped(){
        self.selectBankAccountView.isHidden = false
        self.selectBankAccountView.alpha = 0
        self.accountFormContainer.accountNumberTextField.text = ""
        self.accountFormContainer.phoneNumberTextField.text = ""
        self.accountFormContainer.dobTextField.text = ""
        UIView.animate(withDuration: 0.6, animations: {
            self.accountFormContainer.alpha = 0
        
            self.selectBankAccountView.alpha = 1
        }) { (succeeded) in
            self.accountFormContainer.isHidden = true
            self.accountFormContainer.dobTextField.isHidden = true
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
            self.pinViewContainer.hiddenPinTextField.becomeFirstResponder()
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
    func showWebView(url: String?,ref:String?){
        //Collapse opened Tabs
        self.handelCloseOrExpandSection(section: 0)
        //Show web view
        //let storyBoard = UIStoryboard(name: "Rave", bundle: nil)
        let controller = RavePayWebViewController()
        controller.flwRef = ref
        controller.url = url
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showOTP(message:String, flwRef:String, otpType:OTPType){
        switch otpType {
        case .savedCard:
            self.otpContentContainer.isHidden = false
            otpContentContainer.alpha = 0
            otpContentContainer.otpMessage.text = message
            otpContentContainer.otpButton.removeTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.removeTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.addTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
            
            UIView.animate(withDuration: 0.6, animations: {
                self.otpContentContainer.alpha = 1
                self.pinViewContainer.alpha = 0
                self.debitCardView.alpha = 0
                self.saveCardContainer.alpha = 0
            }) { (success) in
                self.pinViewContainer.isHidden = true
                self.debitCardView.isHidden = true
                self.saveCardContainer.isHidden = true
            }
            
        case .card:
            self.otpContentContainer.isHidden = false
            otpContentContainer.alpha = 0
            otpContentContainer.otpMessage.text = message
            otpContentContainer.otpButton.removeTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.removeTarget(self, action: #selector(saveCardOTPButtonTapped), for: .touchUpInside)
            otpContentContainer.otpButton.addTarget(self, action: #selector(cardOTPButtonTapped), for: .touchUpInside)
            
            
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
            self.otpContentContainer.isHidden = false
            accountOtpContentContainer.alpha = 0
            accountOtpContentContainer.otpMessage.text = message
            accountOtpContentContainer.otpTextField.text = ""
            accountOtpContentContainer.otpButton.addTarget(self, action: #selector(accountOTPButtonTapped), for: .touchUpInside)
            raveAccountClient.transactionReference = flwRef
            UIView.animate(withDuration: 0.6, animations: {
                self.accountOtpContentContainer.alpha = 1
                self.accountFormContainer.alpha = 0
                self.selectBankAccountView.alpha = 0
            }) { (success) in
                self.accountFormContainer.isHidden = true
                self.selectBankAccountView.isHidden = true
            }
        }
    }
    @objc func accountOTPButtonTapped(){
        self.view.endEditing(true)
        
        guard let otp = accountOtpContentContainer.otpTextField.text, otp != ""  else {
            return
        }
        LoadingHUD.shared().show()
        raveAccountClient.otp = otp
        raveAccountClient.validateAccountOTP()
    }
    
    @objc func cardOTPButtonTapped(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        guard let otp = otpContentContainer.otpTextField.text, otp != ""  else {
            return
        }
        raveCardClient.otp = otp
        raveCardClient.validateCardOTP()
    }
    
    @objc func saveCardOTPButtonTapped(){
        self.view.endEditing(true)
        guard let otp = otpContentContainer.otpTextField.text, otp != ""  else {
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
        guard let pin = self.pinViewContainer.hiddenPinTextField.text else {return}
        raveCardClient.bodyParam?.merge(["suggested_auth":"PIN","pin":pin])
        raveCardClient.chargeCard()
    }
    
    @objc func billAddressButtonTapped(){
        guard let zip = self.billingAddressContainer.zipCodeTextField.text, zip != "" else{
            self.billingAddressContainer.zipCodeTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.billingAddressContainer.zipCodeTextField.layer.borderWidth = 0.5
            return
        }
        guard let city = self.billingAddressContainer.cityTextField.text, city != "" else{
            self.billingAddressContainer.zipCodeTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.billingAddressContainer.zipCodeTextField.layer.borderWidth = 0.5
            return
        }
        guard let address = self.billingAddressContainer.billingAddressTextField.text, address != "" else{
            self.billingAddressContainer.billingAddressTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.billingAddressContainer.billingAddressTextField.layer.borderWidth = 0.5
            return
        }
        guard let country = self.billingAddressContainer.countryTextField.text, country != "" else{
            self.billingAddressContainer.countryTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.billingAddressContainer.countryTextField.layer.borderWidth = 0.5
            return
        }
        guard let state = self.billingAddressContainer.stateTextField.text, state != "" else{
            self.billingAddressContainer.stateTextField.layer.borderColor = UIColor(hex: "#E85641").cgColor
            self.billingAddressContainer.stateTextField.layer.borderWidth = 0.5
            return
        }
        self.billAddressAction()
    }
    
    func billAddressAction(){
        self.view.endEditing(true)
        LoadingHUD.shared().show()
        guard let zip = self.billingAddressContainer.zipCodeTextField.text, let city = self.billingAddressContainer.cityTextField.text,
            let address = self.billingAddressContainer.billingAddressTextField.text, let country = self.billingAddressContainer.countryTextField.text , let state = self.billingAddressContainer.stateTextField.text else {return}
        raveCardClient.bodyParam?.merge(["suggested_auth":"NOAUTH_INTERNATIONAL","billingzip":zip,"billingcity":city,
                                         "billingaddress":address,"billingstate":state, "billingcountry":country])
        raveCardClient.chargeCard()
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 12 {
            if let count = self.banks?.count{
                return count
            }else{
                return 0
            }
        }else if  pickerView.tag == 17{
            return RaveConstants.zambianNetworks.count
        }
        else{
            return RaveConstants.ghsMobileNetworks.count
        }
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 12 {
            return self.banks?[row].name
        }else  if pickerView.tag == 17 {
                   return  RaveConstants.zambianNetworks[row]
        }
        else{
            return RaveConstants.ghsMobileNetworks[row].0
        }
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 12 {
            self.selectedBankCode = self.banks?[row].bankCode
            self.selectBankAccountView.otherBanksTextField.text = self.banks?[row].name
        }else if pickerView.tag == 17 {
            self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.text = RaveConstants.zambianNetworks[row]
            raveMobileMoneyZM.network = RaveConstants.zambianNetworks[row]
        }
        else{
            self.mobileMoneyContentView.mobileMoneyChooseNetwork.text = RaveConstants.ghsMobileNetworks[row].0
            self.mobileMoneyContentView.mobileMoneyTitle.text = RaveConstants.ghsMobileNetworks[row].1
            
            if (RaveConstants.ghsMobileNetworks[row].0 == "VODAFONE"){
                mobileMoneyContentView.mobileMoneyVoucher.isHidden = false
            }else{
                mobileMoneyContentView.mobileMoneyVoucher.isHidden = true
            }
            raveMobileMoney.selectedMobileNetwork = RaveConstants.ghsMobileNetworks[row].0
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
