//
//  User.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/16.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let id: String?
    let name: String
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    init(id: String, documentData: [String: Any]) {
        self.id = id
        self.name = documentData["name"] as! String
    }
    
    var documentData: [String: Any] {
        return [
            "name": name,
        ]
    }
}
