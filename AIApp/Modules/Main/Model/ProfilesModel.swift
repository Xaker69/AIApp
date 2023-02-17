import IGListDiffKit

class ProfilesModel {
    let users: [User]
    
    init(users: [User]) {
        self.users = users
    }
}

extension ProfilesModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return users.map { $0.id } as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.users == users
    }
}
