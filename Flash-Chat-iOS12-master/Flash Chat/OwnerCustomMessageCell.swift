//
//  OwnerCustomMessageCell.swift
//  Flash Chat
//
//  Created by Jayyoung Yang on 27/12/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class OwnerCustomMessageCell: UITableViewCell {

    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
