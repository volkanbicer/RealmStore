# RealmStore

A lightweight library base on [RealmSwift](https://github.com/realm/realm-cocoa). RealmSwift usage simple. RealStore provides simplest usage.

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
