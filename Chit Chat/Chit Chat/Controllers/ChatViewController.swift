//
//  ChatViewController.swift
//  Chit Chat
//
//  Created by Prashuk Ajmera on 21/10/2020.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        title = K.appName
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName).getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let snapshotDocument = querySnapshot?.documents {
                for doc in snapshotDocument {
                    let data = doc.data()
                    if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                        let message = Message(sender: messageSender, body: messageBody)
                        self.messages.append(message)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("Success")
            }
        }
    }
    
}

// MARK:- TableView Delegates
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLbl.text = messages[indexPath.row].body
        return cell
    }
}


