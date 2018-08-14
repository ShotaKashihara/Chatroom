//
//  ChatroomViewController.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/08.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

class ChatroomViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var inputBottomView: UIView!
    
    override var inputAccessoryView: UIView? {
        return inputBottomView
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let inputView = ChatroomInputView.instantiate()
        self.inputBottomView = inputView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexPath = IndexPath.init(row: 99, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ChatroomViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath)
        if let chatCell = cell as? ChatTableViewCell {
            chatCell.ownTextLabel.text = "\(indexPath.row)行目だよ。"
        }
        return cell
    }
}

// MARK: - Keyboard制御
extension ChatroomViewController {
    
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
