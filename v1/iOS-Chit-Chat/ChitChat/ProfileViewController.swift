//
//  ProfileViewController.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 16/05/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBar.target = self.revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
}
