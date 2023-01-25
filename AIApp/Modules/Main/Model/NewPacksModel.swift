import IGListDiffKit

class NewPacksModel {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension NewPacksModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.name == name
    }
}

