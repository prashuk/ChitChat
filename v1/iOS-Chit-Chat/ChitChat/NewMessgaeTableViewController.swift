//
//  NewMessgaeTableViewController.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 29/04/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit
import Firebase

class NewMessgaeTableViewController: UITableViewController {

    var users = [User]()
    let menuBar = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))

        
        fetchUsers()
    }
    
    func fetchUsers() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                //if we use directly tableView.reloadData() app will crash so it is in background tread, so lets use OperationQueue.main to fix
                OperationQueue.main.addOperation {
                    self.users = self.users.sorted{ (a, b) in (a.name!) < (b.name!) }
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNewMessage", for: indexPath) as! NewMessageTableViewCell
        cell.name.text = users[indexPath.row].name
        cell.emal.text = users[indexPath.row].email
        cell.profileImage?.sd_setImage(with: URL(string: users[indexPath.row].profileImageURL!), placeholderImage: #imageLiteral(resourceName: "people"), options: [.continueInBackground, .progressiveDownload])
    
        //-Old Method : Very slow downloading
        /*let url = NSURL(string: users[indexPath.row].profileImageURL!)
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            OperationQueue.main.addOperation {
                let data = NSData(contentsOf: url! as URL)
                cell.imageView?.image = UIImage(data: data! as Data)
            }
        }.resume()*/
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
