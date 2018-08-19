//
//  ChatRepository.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/20.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Firebase

class ChatRepository {
    static let shared = ChatRepository()
    
    func root(roomId: String) -> CollectionReference {
        return Firestore.firestore().collection("rooms").document(roomId).collection("chats")
    }
    
    var listener: ListenerRegistration?
    
    static let refreshNotificationName = Notification.Name.init("refreshChat")
    
    func listen(_ roomId: String) {
        listener?.remove()
        listener = root(roomId: roomId)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("\(error!)")
                    return
                }
                NotificationCenter.default.post(name: ChatRepository.refreshNotificationName, object: documents)
        }
    }
    
    func save(_ room: Room, chat: Room.Chat) {
        guard let roomId = room.id else {
            assertionFailure()
            return
        }
        if let documentId = chat.id {
            root(roomId: roomId).document(documentId).updateData(chat.documentData)
        } else {
            let newDocument = root(roomId: roomId).document()
            newDocument.setData(chat.documentData)
        }
    }
}
