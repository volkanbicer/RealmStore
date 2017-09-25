//
//  RealmStore.swift
//  RealmStore
//
//  Created by volkan biçer on 23/09/2017.
//  Copyright © 2017 volkanbicer. All rights reserved.
//

import Foundation
import RealmSwift


public class RealmStore<T:RealmEntity>{
    fileprivate let realm: Realm!
    
    
    public init(){
        realm = try! Realm()
    }
    
    public init(inMemoryIdentifier: String) {
            realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: inMemoryIdentifier))
    }
    
    public init(with realmConfig: Realm.Configuration){
        realm = try! Realm(configuration: realmConfig)
    }
    
    public func getAll() -> [T]{
        return realm.objects(T.EntityType.self).flatMap { T($0) }
    }
    
    
    public func insert(_ item: T, update: Bool = false){
        try! realm.write{
            realm.add(item.entity, update: update)
        }
    }
    
    
    public func bulkInsert(_ items: [T]){
        for item in items{
            insert(item)
        }
    }
    
    
    public func clean(){
        try! realm.write{
            realm.delete(realm.objects(T.EntityType.self))
        }
    }
    
}


extension RealmStore where T:RealmQuery{
    public func filter(with query: T.Query) -> [T]{
        var items = realm.objects(T.EntityType.self)
        
        if let predicate = query.predicate{
            items = items.filter(predicate)
        }
        
        items = items.sorted(by: query.sortDescriptors)
        return items.flatMap { T($0) }
    }
}
