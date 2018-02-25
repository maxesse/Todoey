//
//  Item.swift
//  Todoey
//
//  Created by Max Sanna on 25/02/2018.
//  Copyright © 2018 Max Sanna. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
