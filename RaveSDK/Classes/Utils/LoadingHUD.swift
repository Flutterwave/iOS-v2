//
//  LoadingHUD.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 04/08/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit
import Lottie

class LoadingHUD: UIView {
    //let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var animation:AnimationView!
    
    var bgColor: UIColor? = .clear
    var applyBlur = true
    var animationFile = "Loader_YW"
    var blurView:UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    class func shared() -> LoadingHUD{
        struct Static {
            static let loader = LoadingHUD(frame: (UIScreen.main.bounds))
            
        }
        return Static.loader
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI(){
        
    }
    
    func show(){
        backgroundColor = bgColor
        if(applyBlur){
            insertSubview(blurView, at: 0)
            blurView.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
            blurView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
		
        
		animation = AnimationView(name: animationFile, bundle: Bundle.getResourcesBundle() ?? Bundle.main)
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animation)
        animation.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        animation.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        animation.widthAnchor.constraint(equalToConstant: 80).isActive = true
        animation.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.animation.play()
        UIApplication.shared.keyWindow?.addSubview(self)
        isHidden = false
    }
    func showInView(view:UIView){
        backgroundColor = bgColor
        if(applyBlur){
            insertSubview(blurView, at: 0)
            blurView.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
            blurView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        animation = AnimationView(name: animationFile)
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animation)
        animation.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        animation.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        animation.widthAnchor.constraint(equalToConstant: 80).isActive = true
        animation.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.animation.play()
        view.addSubview(self)
        
        isHidden = false
    }
    
    func hide(){
//        animation.stop()
        isHidden = true
        removeFromSuperview()
    }
}

