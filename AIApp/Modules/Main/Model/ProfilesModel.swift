import IGListDiffKit

class ProfilesModel {
    let persons: [Person]
    
    init(persons: [Person]) {
        self.persons = persons
    }
}

extension ProfilesModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return persons as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.persons == persons
    }
}
