//
//  ChatroomViewController.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/08.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit
import Firebase

class ChatroomViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType {
        return .initial
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var dataSources: [ChatTableViewCellModel] = []
    
    var opponentId: String! 
    
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
        inputView.delegate = self
        self.inputBottomView = inputView
        self.topConstraint.constant = inputView.bounds.height
        
        // キーボード制御の拡張
        self.registerKeyboardNotification()
        
        // Observer定義
        NotificationCenter.default.addObserver(forName: ChatRepository.refreshNotificationName, object: nil, queue: nil) { notification in
            print("\(notification)")
            guard let documents = notification.object as? [QueryDocumentSnapshot] else {
                return
            }
        }
        // Listener開始
        ChatRepository.shared.listen(self.opponentId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dataSources = [
            OwnChatTableViewCellModel(text: "こんにちは", timestamp: Date().addingTimeInterval(1)),
            OwnChatTableViewCellModel(text: "こんにちは", timestamp: Date().addingTimeInterval(2)),
            OpponentChatTableViewCellModel(text: "こんにちは", timestamp: Date().addingTimeInterval(3)),
            OwnChatTableViewCellModel(text: "こんにちは", timestamp: Date().addingTimeInterval(4)),
        ]
        self.tableView.reloadData()
        let indexPath = IndexPath.init(row: self.dataSources.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ChatroomViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.dataSources[indexPath.row] {
        case let model as OwnChatTableViewCellModel:
            let cell = tableView.dequeueReusableCell(with: OwnChatTableViewCell.self, for: indexPath)
            cell.model = model
            return cell
        case let model as OpponentChatTableViewCellModel:
            let cell = tableView.dequeueReusableCell(with: OpponentChatTableViewCell.self, for: indexPath)
            cell.model = model
            return cell
        default:
            abort()
        }
    }
}

// MARK: - 送信ボタン
extension ChatroomViewController: ChatroomInputViewDelegate {
    func tapSendButton(text: String) {
//        let newChat = Chat(opponentId: self.opponentId, message: text)
//        ChatRepository.shared.save(newChat)
    }
}
