//
//  ViewController.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 27/04/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var leftBarBtn: UIBarButtonItem!
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        checkIfUserIsLoggedIn()
        navigationItem.titleView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
        navigationItem.titleView?.isUserInteractionEnabled = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        navigationItem.titleView = activityIndicator
        
    }
    
    func checkIfUserIsLoggedIn() {
        activityIndicator.startAnimating()
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    self.activityIndicator.stopAnimating()
                    self.navigationItem.titleView = nil
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : AnyObject] {
                    self.activityIndicator.stopAnimating()
                    self.navigationItem.titleView = nil
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
            navigationItem.title = nil
            performSegue(withIdentifier: "logoutTap", sender: nil)
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    func showChatController() {
        let chatLog = ChatLogController()
        navigationController?.pushViewController(chatLog, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    @IBAction func backToMessages(segue: UIStoryboardSegue) {}
}

