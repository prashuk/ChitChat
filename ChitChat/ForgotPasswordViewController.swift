//
//  ForgotPasswordViewController.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 5/10/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    var emailTextField : kTextFiledPlaceHolder!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField = kTextFiledPlaceHolder.init(frame: CGRect(origin: CGPoint(x: 16,y :130), size: CGSize(width: 343, height: 40)))
        emailTextField.placeholder = "Email"
        emailTextField.placeHolderColor = UIColor.white
        emailTextField.difference = 30
        emailTextField.directionMaterial = placeholderDirection.placeholderDown
        emailTextField.textColor = UIColor.white
        emailTextField.delegate = self
        emailTextField.tag = 0
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        self.view.addSubview(emailTextField)
        
    }
    
    @IBAction func backForgotInBtnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetBtnTap(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.effectView.isHidden = false
        activityIndicator("Reseting...")
        if (emailTextField.text == "") {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.effectView.isHidden = true
            let alert = UIAlertController(title: "Error", message: "Email can't be empty.", preferredStyle: UIAlertControllerStyle.alert)
            let loginAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(loginAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            
        }
        
    }
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.addSubview(activityIndicator)
        effectView.addSubview(strLabel)
        view.addSubview(effectView)
    }
}
