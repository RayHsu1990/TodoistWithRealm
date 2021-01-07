//
//  RealmManager.swift
//  TodoistWithRealm
//
//  Created by Ray Hsu on 2021/1/6.
//

import Foundation
import RealmSwift


class RealmManager {
    
    static let shared = RealmManager()
    private init(){
        realm = try! Realm()
    }
    
    
    private var realm : Realm!
    
    
    func add(objects: [Object],_ completion: (()->Void)? = nil){
        try! realm.write { realm.add(objects) }
        
        if let completion = completion {
            completion()
        }
    }
    
    func read(_ completion: (()->Void)? = nil)-> [ListModel]{
        if let completion = completion {
            completion()
        }
        return realm.objects(ListModel.self).toArray(type: ListModel.self)
        
    }
    
    func updateContent(list: ListModel, text: String){
        try! realm.write {
            realm.objects(ListModel.self)[0].text = text
            for i in realm.objects(ListModel.self){
                if i.title == list.title {
                    i.text = text
                }
            }
        }
    }
    
    func delete(list: ListModel,_ completion: (()->Void)? = nil){
        try! realm.write{
            realm.delete(list)
        }
        if let completion = completion {
            completion()
        }

    }
    
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

