//
//  UserRepository.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/16.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Firebase

class UserRepository {
    static let shared = UserRepository()
    
    let root = Firestore.firestore().collection("users")
    
    var listener: ListenerRegistration?
    
    static let refreshNotificationName = Notification.Name.init("refreshUser")
    
    func listen() {
        listener?.remove()
        listener = root
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("\(error!)")
                    return
                }
                let users = documents.map {
                    return User.init(id: $0.documentID, documentData: $0.data())
                }
                NotificationCenter.default.post(name: UserRepository.refreshNotificationName, object: users)
        }
    }
    
    func save(_ user: User) {
        if let documentId = user.id {
            root.document(documentId).setData(user.documentData, options: SetOptions.merge())
        } else {
            let newDocument = root.document()
            newDocument.setData(user.documentData)
        }
    }
}
