//
//  ChatroomInputView.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/15.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

class ChatroomInputView: UIView, NibInstantiatable {

    @IBOutlet weak var textView: UITextView!
    
    @IBAction func tapSendButton(_ sender: UIButton) {
        self.textView.resignFirstResponder()
    }
}
