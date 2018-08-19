//
//  AppDelegate.swift
//  Chatroom
//
//  Created by Shota Kashihara on 2018/08/08.
//  Copyright © 2018年 Shota Kashihara. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var uid: String! = UserDefaults.standard.string(forKey: "uid")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously { (authUser, error) in
            guard let authUser = authUser else {
                print(error!)
                abort()
            }
            self.uid = authUser.uid
            UserDefaults.standard.set(authUser.uid, forKey: "uid")
            let user = User(id: authUser.uid, name: "ぼく")
            UserRepository.shared.save(user)
        }
        return true
    }
}

extension UIApplicationDelegate {
    static var shared: Self {
        return UIApplication.shared.delegate! as! Self
    }
}
