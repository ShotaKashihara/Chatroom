//
//  OpponentChatTableViewCell.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/08.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

class OpponentChatTableViewCell: UITableViewCell {
    
    var model: OpponentChatTableViewCellModel! {
        didSet {
            self.setView()
        }
    }
    
    @IBOutlet weak var opponentTextLabel: UILabel!
    
    private func setView() {
        self.opponentTextLabel.text = model.text
    }
}
