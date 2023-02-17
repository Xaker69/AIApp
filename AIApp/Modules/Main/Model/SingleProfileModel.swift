import IGListDiffKit

class SingleProfileModel {
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
}

extension SingleProfileModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return (user?.id ?? "user") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.user == user
    }
}
