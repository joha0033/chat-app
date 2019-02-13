//
//  ChatTableViewCell.swift
//  chat-app-02-2019
//
//  Created by WebLedDevelopment on 2/12/19.
//  Copyright © 2019 WebLedDevelopment. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageText.layer.cornerRadius = 10
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
