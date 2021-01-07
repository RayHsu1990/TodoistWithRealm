//
//  MainPageModel.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import Foundation
import RealmSwift


class ListModel : Object {
    @objc dynamic var title = ""
    @objc dynamic var text = ""
    
}
