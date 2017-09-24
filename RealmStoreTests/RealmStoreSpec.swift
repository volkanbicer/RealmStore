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
                for i in 1...2{
                    publisherStore.insert(Publisher(name: "Volkan", surname: "Bicer"))
                }
                
                expect(publisherStore.getAll().count).to(equal(2))

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

