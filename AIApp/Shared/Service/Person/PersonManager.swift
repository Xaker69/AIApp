import RealmSwift

class PersonManager {
    
    static let shared = PersonManager()
    let personQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).personQueue")
    
    func createPerson(images: [UIImage], gender: String, name: String) {
        personQueue.async {
            do {
                let realm = try Realm()
                let person = Person()
                person.name = name
                person.gender = gender
                person.photos.append(objectsIn: images.compactMap { $0.pngData() })
                
                try realm.write {
                    realm.add(person)
                    print("💙 person created")
                }
            } catch {
                print("❤️‍🩹 error addPerson(person:), ", error)
            }
        }
    }
        
    func getPersons() -> Results<Person>? {
        personQueue.sync {
            do {
                let realm = try Realm()
                
                var persons: Results<Person>
                persons = realm.objects(Person.self)
                
                return persons
            } catch {
                print("❤️‍🩹 error getPersons(), ", error)
                return nil
            }
        }
    }
    
    func deletePerson(person: Person) {
        personQueue.async {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.delete(person)
                }
            } catch {
                print("❤️‍🩹 error deletePerson(person:), ", error)
            }
        }
    }
}

