//
//  AppDelegate.swift
//  Todoey
//
//  Created by Max Sanna on 22/02/2018.
//  Copyright © 2018 Max Sanna. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

//        print(Realm.Configuration.defaultConfiguration.fileURL!)

        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: Category.className()) { (old, new) in
                        new!["dateCreated"] = Date()
                    }
                    migration.enumerateObjects(ofType: Item.className()) { (old, new) in
                        new!["dateCreated"] = Date()
                    }
                }
                if (oldSchemaVersion < 2) {
                    migration.enumerateObjects(ofType: Category.className()) { (old, new) in
                        new!["colour"] = UIColor.randomFlat.hexValue()
                    }
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

}

