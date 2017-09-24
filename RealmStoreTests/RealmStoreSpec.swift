//
//  RealmStoreTests.swift
//  RealmStoreTests
//
//  Created by volkan biçer on 23/09/2017.
//  Copyright © 2017 volkanbicer. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import RealmStore

class RealmStoreSpec: QuickSpec {
    
    override func spec(){
        describe("Realm store"){
            
            let publisherStore = RealmStore<Publisher>("test")
            
            afterEach{
                publisherStore.clean()
            }
            
            it("inserts new item"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                let publisher = Publisher(name: "Volkan", surname: "Bicer")
                publisherStore.insert(publisher)
                
                expect(publisherStore.getAll().count).to(equal(1))
            }
            
            it("inserts array of item"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                var pusblishers = [Publisher]()
                pusblishers.append(Publisher(name: "Volkan", surname: "Bicer"))
                pusblishers.append(Publisher(name: "Volkan", surname: "Bicer"))
                pusblishers.append(Publisher(name: "Volkan", surname: "Bicer"))
                publisherStore.bulkInsert(pusblishers)
                
                expect(publisherStore.getAll().count).to(equal(3))
            }
            
            it("cleans database"){
                let publisher = Publisher(name: "Volkan", surname: "Bicer")
                publisherStore.insert(publisher)
                publisherStore.clean()
                
                expect(publisherStore.getAll().count).to(equal(0))
            }
            
            it("gets all item"){
                for _ in 1...2{
                    publisherStore.insert(Publisher(name: "Volkan", surname: "Bicer"))
                }
                
                expect(publisherStore.getAll().count).to(equal(2))
            }
            
            it("filters"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                publisherStore.insert(Publisher(name: "Volkan", surname: "Bicer"))
                publisherStore.insert(Publisher(name: "Agatha", surname: "Christie"))
                
                let filteredPublishers = publisherStore.filter(with: .name("Volkan"))
                
                expect(filteredPublishers).notTo(beNil())
                expect(filteredPublishers.count).to(equal(1))

            }
        }
    }
    
    
}


struct Publisher {
    public let name: String
    public let surname: String
}

class PublisherEntity: Object{
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
}

extension Publisher: RealmEntity{
    public init(_ entity: PublisherEntity){
        name = entity.name
        surname = entity.surname
    }
    
    public var entity: PublisherEntity{
        let publisher = PublisherEntity()
        publisher.name = name
        publisher.surname = surname
        return publisher
    }
}


extension Publisher: RealmQuery{
    enum Query: QueryType{
        case name(String)
        case surname(String)
        
        var predicate: NSPredicate?{
            switch self {
            case .name(let value):
                return NSPredicate(format: "name == %@", value)
            case .surname(let value):
                return NSPredicate(format: "surname == %@", value)
            }
        }
        
        var sortDescriptors: [SortDescriptor]{
            return [SortDescriptor(keyPath:"name")]
        }
    }
}

