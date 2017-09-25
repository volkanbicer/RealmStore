# RealmStore

[![Build Status](https://travis-ci.org/vbicer/RealmStore.svg?branch=master)](https://travis-ci.org/vbicer/RealmStore)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/RealmStore.svg)](https://img.shields.io/cocoapods/v/RealmStore.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Language](https://img.shields.io/badge/languages-swift-orange.svg)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/vbicer/realmstore)](http://clayallsopp.github.io/readme-score?url=https://github.com/vbicer/realmstore)

A lightweight framework which provides abstraction for database operations, base on [RealmSwift](https://github.com/realm/realm-cocoa). RealmSwift usage simple. RealStore provides simplest usage.

# Usage
Create your own model:

```swift
struct Publisher {
    public let name: String
    public let surname: String
}
```

Create realm object:

```swift
class PublisherEntity: Object{
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
}
```

Implement `RealmEntity` protocol which does the magic. 

```swift
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
```

Create your store. Usage is as simple as possible. All realm operations done with your model `Publisher`.  

```swift
let publisherStore = RealmStore<Publisher>()
let publisher = Publisher(name:"Volkan", surname: "Bicer")

//inserts publisher
publisherStore.insert(publisher)

//returns [Publisher]
let publisherList = publishStore.getAll()

//removes publishers from database
publisherStore.clean()

```
### Query
To query you must implement `RealmQuery` protocol. Simple usage shown below.
```swift
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
```
To query objects just use filter function. It returns an array.
```swift
let publisherStore = RealmStore<Publisher>()
publisherStore.insert(Publisher(name: "Volkan", surname: "Bicer"))
let filteredPublishers = publisherStore.filter(with: .name("Volkan"))
```

# Installation
RealmStore can be added to your project using [CocoaPods](https://cocoapods.org/) by adding the following line to your Podfile:
```
pod 'RealmStore', :git => 'https://github.com/vbicer/RealmStore'
```

If you're using [Carthage](https://github.com/Carthage/Carthage) you can add a dependency on RealmStore by adding it to your Cartfile:
```
github "https://github.com/vbicer/RealmStore"
```
