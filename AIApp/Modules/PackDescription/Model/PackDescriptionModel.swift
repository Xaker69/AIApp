import IGListDiffKit

class PackDescriptionModel {
    let description: String
    let image: String
    let title: String
    
    init(description: String, image: String, title: String) {
        self.description = description
        self.image = image
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
