//
//  Room.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/19.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Foundation
import Firebase

struct Room {
    let id: String?
    let name: String
    let members: [DocumentReference]
    
    init(id: String? = nil, name: String, members: [String]) {
        self.id = id
        self.name = name
        self.members = members.map {
            return UserRepository.shared.root.document($0)
        }
    }
    
    init(id: String, documentData: [String: Any]) {
        self.id = id
        self.name = documentData["name"] as! String
        self.members = documentData["members"] as! [DocumentReference]
    }
    
    var documentData: [String: Any] {
        return [
            "name": name,
            "members": members,
        ]
    }
    
    struct Chat {
        let id: String?
        let ownerId: String
        let message: String
        let timestamp: Date?
        
        init(id: String? = nil, opponentId: String, message: String) {
            self.id = id
            self.ownerId = AppDelegate.shared.uid
            self.message = message
            self.timestamp = nil
        }
        
        init(id: String? = nil, documentData: [String: Any]) {
            self.id = id
            self.ownerId = documentData["ownerId"] as! String
            self.message = documentData["message"] as! String
            self.timestamp = documentData["timestamp"] as? Date
        }
        
        var documentData: [String: Any] {
            return [
                "ownerId": ownerId,
                "message": message,
                "timestamp": timestamp ?? FieldValue.serverTimestamp(),
            ]
        }
    }
}
