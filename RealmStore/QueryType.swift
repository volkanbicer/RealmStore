//
//  QueryType.swift
//  RealmStore
//
//  Created by volkan biçer on 23/09/2017.
//  Copyright © 2017 volkanbicer. All rights reserved.
//

import Foundation
import RealmSwift

public protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [SortDescriptor] { get }
}



