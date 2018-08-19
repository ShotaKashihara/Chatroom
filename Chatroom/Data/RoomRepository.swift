//
//  RoomRepository.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/16.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Firebase

class RoomRepository {
    static let shared = RoomRepository()
    
    let root = Firestore.firestore().collection("rooms")
    
    static let refreshNotificationName = Notification.Name.init("refreshRoom")
    
    func save(_ room: Room) {
        if let documentId = room.id {
            root.document(documentId).updateData(room.documentData)
        } else {
            let newDocument = root.document()
            newDocument.setData(room.documentData)
        }
    }
}
