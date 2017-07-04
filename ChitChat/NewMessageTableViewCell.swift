//
//  NewMessageTableViewCell.swift
//  ChitChat
//
//  Created by PRASHUK AJMERA on 06/05/17.
//  Copyright © 2017 PRASHUK AJMERA. All rights reserved.
//

import UIKit

class NewMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
