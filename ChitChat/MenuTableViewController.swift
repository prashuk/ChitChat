//
//  HamburgerTableViewController.swift
//  BestBuy_iOS
//
//  Created by PRASHUK AJMERA on 4/21/17.
//  Copyright © 2017 Prashuk. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data = ["Account", "Profile", "Contacts", "Share ChitChat", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor(red: 253/255, green: 223/255, blue: 219/255, alpha: 1)
        view.backgroundColor = UIColor(red: 253/255, green: 223/255, blue: 219/255, alpha: 1)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: data[indexPath.row], for: indexPath) as! MenuTableViewCell
        cell.menuLbl.text = data[indexPath.row]
        let imageName = "p\(indexPath.row).png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        cell.menuImg = imageView
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: 251/255, green: 74/255, blue: 40/255, alpha: 1)
    }
    
}
