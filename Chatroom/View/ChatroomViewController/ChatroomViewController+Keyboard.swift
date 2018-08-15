//
//  ChatroomViewController+Keyboard.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/15.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Keyboard制御
extension ChatroomViewController {
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform.init(translationX: 0, y: -rect.size.height)
            self.view.transform = transform
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let inputViewHeight = self.inputBottomView.bounds.height
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform.init(translationX: 0, y: -inputViewHeight)
            self.view.transform = transform
        }
    }
}
