//
//  RegisterViewController.swift
//  Chit Chat
//
//  Created by Prashuk Ajmera on 21/10/2020.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
        }
    }
    
}
