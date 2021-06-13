//
//  WelcomeViewController.swift
//  Chit Chat
//
//  Created by Prashuk Ajmera on 21/10/2020.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var charIndex = 0.0
//        titleLabel.text = ""
//        let titleText = "⚡️ChitChat"
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//        }
        
        titleLabel.text = "⚡️ChitChat"
    }
}
