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
            
            let publisherStore = RealmStore<Publisher>(inMemoryIdentifier: "RealmStoreSpec")
            
            afterEach{
                publisherStore.clean()
            }
            
            it("inserts new item"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                publisherStore.insert(Publisher(id: 0, name: "Volkan", surname: "Bicer"))
                
                expect(publisherStore.getAll().count).to(equal(1))
            }
            
            
            it("updates item"){
                expect(publisherStore.getAll().count).to(equal(0))

                publisherStore.insert(Publisher(id: 0, name: "Volkan", surname: "Bicer"))
                var publisher = publisherStore.getAll().first!
                publisher.name = "Uras"
                publisherStore.insert(publisher, update: true)
                let updatedPublisher = publisherStore.getAll().first!

                expect(updatedPublisher.name).to(equal("Uras"))
            }
            
            
            it("inserts array of item"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                var pusblishers = [Publisher]()
                pusblishers.append(Publisher(id: 0, name: "Volkan", surname: "Bicer"))
                pusblishers.append(Publisher(id: 1, name: "Volkan", surname: "Bicer"))
                pusblishers.append(Publisher(id: 2, name: "Volkan", surname: "Bicer"))
                publisherStore.bulkInsert(pusblishers)
                
                expect(publisherStore.getAll().count).to(equal(3))
            }
            
            it("cleans database"){
                publisherStore.insert(Publisher(id: 0, name: "Volkan", surname: "Bicer"))
                publisherStore.clean()
                
                expect(publisherStore.getAll().count).to(equal(0))
            }
            
            it("gets all item"){
                for i in 1...2{
                    publisherStore.insert(Publisher(id: i, name: "Volkan", surname: "Bicer"))
                }
                
                expect(publisherStore.getAll().count).to(equal(2))
            }
            
            it("filters"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                publisherStore.insert(Publisher(id: 0, name: "Volkan", surname: "Bicer"))
                publisherStore.insert(Publisher(id: 1, name: "Uras", surname: "Bicer"))
                
                let filteredPublishers = publisherStore.filter(with: .name("Volkan"))
                
                expect(filteredPublishers).notTo(beNil())
                expect(filteredPublishers.count).to(equal(1))

            }
            
            
            it("delete items by query"){
                expect(publisherStore.getAll().count).to(equal(0))
                
                publisherStore.insert(Publisher(id: 0, name: "Volkan", surname: "Bicer"))
                publisherStore.insert(Publisher(id: 1, name: "Uras", surname: "Bicer"))
                publisherStore.insert(Publisher(id: 2, name: "Volkan", surname: "D"))

                
                publisherStore.delete(by: .name("Volkan"))
                
                expect(publisherStore.getAll().count).to(equal(1))
                
            }
        }
    }
    
    
}


struct Publisher {
    public var id: Int
    public var name: String
    public let surname: String
}

class PublisherEntity: Object{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Publisher: RealmEntity{
    public init(_ entity: PublisherEntity){
        name = entity.name
        surname = entity.surname
        id = entity.id
    }
    
    public var entity: PublisherEntity{
        let publisher = PublisherEntity()
        publisher.name = name
        publisher.surname = surname
        publisher.id = id
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

