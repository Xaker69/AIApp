import IGListDiffKit

class SingleProfileModel {
    let person: Person?
    
    init(person: Person?) {
        self.person = person
    }
}

extension SingleProfileModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return person ?? "person" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.person == person
    }
}
