//
//  MenuTableViewCell.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 16/05/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var menuImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
