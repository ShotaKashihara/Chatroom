//
//  UsersViewController.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/20.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(forName: UserRepository.refreshNotificationName, object: nil, queue: nil) { [weak self] (notification) in
            guard let users = notification.object as? [User] else {
                assertionFailure()
                return
            }
            self?.users = users.filter {
                return $0.id != AppDelegate.shared.uid
            }
            self?.tableView.reloadData()
        }
        UserRepository.shared.listen()
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ChatroomViewController.instantiate()
        viewController.opponentId = users[indexPath.row].id
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
