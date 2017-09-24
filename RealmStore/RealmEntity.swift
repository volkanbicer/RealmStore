//
//  RealmEntity.swift
//  RealmStore
//
//  Created by volkan biçer on 23/09/2017.
//  Copyright © 2017 volkanbicer. All rights reserved.
//

import Foundation
import RealmSwift

public protocol RealmEntity {
    associatedtype EntityType: Object
    
    init(_ entity: EntityType)
    var entity: EntityType { get }
}
