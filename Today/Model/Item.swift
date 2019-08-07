//
//  Item.swift
//  Today
//
//  Created by Phúc Lý  on 8/7/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    @objc dynamic var dateCreated:Date?
    var parentCategory=LinkingObjects(fromType: Category.self, property: "items")
    
}
