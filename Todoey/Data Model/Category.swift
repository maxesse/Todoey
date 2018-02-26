//
//  Category.swift
//  Todoey
//
//  Created by Max Sanna on 25/02/2018.
//  Copyright © 2018 Max Sanna. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var colour: String = UIColor.randomFlat.hexValue()
    let items = List<Item>()
}
