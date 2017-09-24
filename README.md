# RealmStore

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
