//
//  LoginViewController.swift
//  Chit Chat
//
//  Created by Prashuk Ajmera on 21/10/2020.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: K.loginSegue, sender: self)
            })
        }
    }
    
}
