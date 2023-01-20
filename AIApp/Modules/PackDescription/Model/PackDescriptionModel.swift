import IGListDiffKit

class PackDescriptionModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

extension PackDescriptionModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return title as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.title == title
    }
}
