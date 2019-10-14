//
//  SnackBar.swift
//  TellerPoint
//
//  Created by Olusegun Solaja  on 07/01/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//
import UIKit

class KeyboardStateListener: NSObject{
    static let shared = KeyboardStateListener()
    var isVisible = false
    var keyboardHeight: CGFloat = 15
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    @objc func didShow(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.keyboardHeight = keyboardHeight
        }
        isVisible = true
    }
    
    @objc func didHide(notification: NSNotification){
        isVisible = false
    }
}


class SnackBar: UIView {
    lazy var typeIndicator: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var statusMessage: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = UIFont(name: "AvenirNext-Regular", size: 13)
        lab.numberOfLines = 0
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
    var message:String?{
        didSet{
            statusMessage.text = message
        }
    }
    var statusColor: UIColor?{
        didSet{
            backgroundColor = statusColor
        }
    }
    lazy var okButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Okay", for: .normal)
        btn.titleLabel!.font = UIFont(name: "AvenirNext-Bold", size: 13)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(hideSnack), for: .touchUpInside)
        return btn
    }()
    static var shared = SnackBar()
    let currentWindow = UIApplication.shared.keyWindow
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        addSubview(typeIndicator)
        typeIndicator.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, size: .init(width: 8, height: frame.height))
        addSubview(statusMessage)
        statusMessage.anchor(top: topAnchor, leading: typeIndicator.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 70))
        addSubview(okButton)
        okButton.anchor(top: topAnchor, leading: statusMessage.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear), name: UIResponder.keyboardDidShowNotification, object: nil)
        
    }
    @objc func keyboardWillAppear() {
        self.viewBottomAnchor?.constant = -(KeyboardStateListener.shared.keyboardHeight + 10)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillDisappear() {
        self.viewBottomAnchor?.constant = -60
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    var viewBottomAnchor:NSLayoutConstraint?
    @objc func hideSnack(){
        UIView.animate(withDuration: 1.5, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveEaseInOut], animations: {
            self.viewBottomAnchor?.constant = 0
            self.layoutIfNeeded()
        }, completion: {(_) in
            self.removeFromSuperview()
        })
    }
    func show(){
        guard let window = UIApplication.shared.keyWindow else {return}
        window.addSubview(self)
        window.bringSubviewToFront(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.viewBottomAnchor = self.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 80)
        self.viewBottomAnchor?.isActive = true
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            self.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20),
            self.heightAnchor.constraint(equalToConstant: 50)
            ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if KeyboardStateListener.shared.isVisible{
                self.viewBottomAnchor?.constant = -(KeyboardStateListener.shared.keyboardHeight + 10)
            }else{
                self.viewBottomAnchor?.constant = -60
            }
            UIView.animate(withDuration: 10, animations: {
                self.layoutIfNeeded()
            }, completion: {(_) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    UIWindow.animate(withDuration: 1.5, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveEaseInOut], animations: {
                        self.viewBottomAnchor?.constant = 0
                        self.layoutIfNeeded()
                    }, completion: {(_) in
                        self.removeFromSuperview()
                    })
                })
            })
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
