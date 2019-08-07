//
//  Category.swift
//  Today
//
//  Created by Phúc Lý  on 8/7/19.
//  Copyright © 2019 Phúc Lý . All rights reserved.
//

import Foundation
import RealmSwift
class Category:Object{
    @objc dynamic var name:String=""
    var items=List<Item>()
}
