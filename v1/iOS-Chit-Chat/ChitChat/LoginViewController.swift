//
//  LoginViewController.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 27/04/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var emailTextField : kTextFiledPlaceHolder!
    var passwordTextField : kTextFiledPlaceHolder!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
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
        
        passwordTextField = kTextFiledPlaceHolder.init(frame: CGRect(origin: CGPoint(x: 16,y :185), size: CGSize(width: 343, height: 40)))
        passwordTextField.placeholder = "Password"
        passwordTextField.placeHolderColor = UIColor.white
        passwordTextField.difference = 30
        passwordTextField.directionMaterial = placeholderDirection.placeholderDown
        passwordTextField.textColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.tag = 1
        passwordTextField.returnKeyType = .done
        self.view.addSubview(passwordTextField)
        
    }
    
    @IBAction func loginBtnTap(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.effectView.isHidden = false
        activityIndicator("Logging...")
        if (emailTextField.text == "" || passwordTextField.text == "") {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.effectView.isHidden = true
            let alert = UIAlertController(title: "Error", message: "Email/Password can't be empty.", preferredStyle: UIAlertControllerStyle.alert)
            let loginAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(loginAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user: FIRUser?, error) in
                if error != nil {
                    print(error!)
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.effectView.isHidden = true
                    let alert = UIAlertController(title: "Error", message: "Email/Password not matched.", preferredStyle: UIAlertControllerStyle.alert)
                    let loginAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                    alert.addAction(loginAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                UIApplication.shared.endIgnoringInteractionEvents()
                self.effectView.isHidden = true
                self.dismiss(animated: true, completion: nil)
                print("Signed In Successfully")
            })
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
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
