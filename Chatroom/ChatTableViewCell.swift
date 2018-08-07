//
//  ChatTableViewCell.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/08.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textBackgroundView: UIView!
    @IBOutlet weak var ownTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 緑背景のViewを角丸にする
        self.textBackgroundView.layer.cornerRadius = 16
    }
}
