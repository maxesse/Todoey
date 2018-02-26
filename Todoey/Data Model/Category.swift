//
//  Category.swift
//  Todoey
//
//  Created by Max Sanna on 25/02/2018.
//  Copyright © 2018 Max Sanna. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated: Date = Date()
    let items = List<Item>()
}
