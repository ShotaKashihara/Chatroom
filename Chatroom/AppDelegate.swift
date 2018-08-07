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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

