import RealmSwift

class Person: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var gender: String = ""
    let photos = List<Data?>()
}
