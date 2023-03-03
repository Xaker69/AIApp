import IGListDiffKit

class MyPacksModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}

extension MyPacksModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return user.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.user == user
    }
}
