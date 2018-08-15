//
//  ChatTableViewCellModel.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/15.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Foundation

class ChatTableViewCellModel {
    let text: String
    let timestamp: Date
    
    init(text: String, timestamp: Date) {
        self.text = text
        self.timestamp = timestamp
    }
}
