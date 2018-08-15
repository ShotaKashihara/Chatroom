//
//  OwnChatTableViewCell.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/08.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

class OwnChatTableViewCell: UITableViewCell {
    
    var model: OwnChatTableViewCellModel! {
        didSet {
            self.setView()
        }
    }
    
    @IBOutlet weak var ownTextLabel: UILabel!
    
    private func setView() {
        self.ownTextLabel.text = model.text
    }
}
