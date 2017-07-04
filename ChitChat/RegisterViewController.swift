//
//  RegisterViewController.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 5/8/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addImageLbl: UILabel!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let picker = UIImagePickerController()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var emailTextField : kTextFiledPlaceHolder!
    var passwordTextField : kTextFiledPlaceHolder!
    var nameTextField : kTextFiledPlaceHolder!
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.allowsEditing = true
        
//        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillShow:")), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillHide:")), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelProfileImage)))
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.contentMode = .center
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        
        nameTextField = kTextFiledPlaceHolder.init(frame: CGRect(origin: CGPoint(x: 125,y :114), size: CGSize(width: 234, height: 40)))
        nameTextField.placeholder = "Name"
        nameTextField.placeHolderColor = UIColor.white
        nameTextField.difference = 30
        nameTextField.directionMaterial = placeholderDirection.placeholderDown
        nameTextField.textColor = UIColor.white
        nameTextField.delegate = self
        nameTextField.tag = 0
        nameTextField.returnKeyType = .next
        nameTextField.keyboardType = .default
        self.view.addSubview(nameTextField)
        
        emailTextField = kTextFiledPlaceHolder.init(frame: CGRect(origin: CGPoint(x: 125,y :168), size: CGSize(width: 234, height: 40)))
        emailTextField.placeholder = "Email"
        emailTextField.placeHolderColor = UIColor.white
        emailTextField.difference = 30
        emailTextField.directionMaterial = placeholderDirection.placeholderDown
        emailTextField.textColor = UIColor.white
        emailTextField.delegate = self
        emailTextField.tag = 1
        emailTextField.returnKeyType = .next
        emailTextField.keyboardType = .emailAddress
        self.view.addSubview(emailTextField)
        
        passwordTextField = kTextFiledPlaceHolder.init(frame: CGRect(origin: CGPoint(x: 125,y :216), size: CGSize(width: 234, height: 40)))
        passwordTextField.placeholder = "Password"
        passwordTextField.placeHolderColor = UIColor.white
        passwordTextField.difference = 30
        passwordTextField.directionMaterial = placeholderDirection.placeholderDown
        passwordTextField.textColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.tag = 2
        passwordTextField.returnKeyType = .done
        self.view.addSubview(passwordTextField)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
    }
//*****************************************************************************************************************************************************
    func handelProfileImage() {
        let myActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let takePicture = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }
        let openPhotos = UIAlertAction(title: "Photo & Video Library", style: UIAlertActionStyle.default) { (action) in
            self.present(self.picker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        myActionSheet.addAction(takePicture)
        myActionSheet.addAction(openPhotos)
        myActionSheet.addAction(cancelAction)
        self.present(myActionSheet, animated: true, completion: nil)
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var seletedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            seletedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            seletedImageFromPicker = originalImage
        }
        let size = CGSize(width: 100, height: 100)
        seletedImageFromPicker = resizeImage(image: seletedImageFromPicker!, targetSize: size)
        addImageLbl.isHidden = true
        profileImageView.image = seletedImageFromPicker
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
//*****************************************************************************************************************************************************
    @IBAction func registerBtnTap(_ sender: Any) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.effectView.isHidden = false
        activityIndicator("Registering...")
        if (nameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "") {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.effectView.isHidden = true
            let alert = UIAlertController(title: "Error", message: "Fields can't be empty.", preferredStyle: UIAlertControllerStyle.alert)
            let loginAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(loginAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user: FIRUser?, error) in
                if error != nil {
                    print(error!)
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.effectView.isHidden = true
                    let alert = UIAlertController(title: "Error", message: "Email already registered.", preferredStyle: UIAlertControllerStyle.alert)
                    let loginAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
                    alert.addAction(loginAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                let imageName = NSUUID().uuidString
                let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
                if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                    storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                            let values = ["name" : self.nameTextField.text!, "email" : self.emailTextField.text!, "profileImageURL" : profileImageURL]
                            self.registerUserInfoIntoDatabaseWithUID(uid: (user?.uid)!, values: values as [String : AnyObject])
                        }
                    })
                }
            })
        }
    }
    func registerUserInfoIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference(fromURL: fireDB)
        let userRef = ref.child("users").child(uid)
        userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                return
            }
            let alert = UIAlertController(title: "Thanks for Registration", message: "Please Login", preferredStyle: UIAlertControllerStyle.alert)
            let loginAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { UIAlertAction in self.dismiss(animated: true, completion: nil)}
            alert.addAction(loginAction)
            UIApplication.shared.endIgnoringInteractionEvents()
            self.effectView.isHidden = true
            self.present(alert, animated: true, completion: nil)
            print("Registered Successfully")
        })
    }
//*****************************************************************************************************************************************************
    @IBAction func backBtnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//*****************************************************************************************************************************************************
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }

//*****************************************************************************************************************************************************
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
    
//    func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if view.frame.origin.y != 0 {
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
//    }

}
