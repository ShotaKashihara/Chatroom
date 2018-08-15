//
//  ChatroomInputView.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/15.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

protocol ChatroomInputViewDelegate {
    func tapSendButton(text: String)
}

class ChatroomInputView: UIView, NibInstantiatable {

    @IBOutlet weak var textView: UITextView!
    
    var delegate: ChatroomInputViewDelegate!
    
    @IBAction func tapSendButton(_ sender: UIButton) {
        guard self.textView.text.count > 0 else {
            return
        }
        self.delegate.tapSendButton(text: self.textView.text)
        self.textView.text = nil
        self.textView.resignFirstResponder()
    }
}
