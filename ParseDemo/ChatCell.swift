//
//  ChatCell.swift
//  ParseDemo
//
//  Created by Deepak on 11/28/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatText: UILabel!
    
    @IBOutlet weak var userNameText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
