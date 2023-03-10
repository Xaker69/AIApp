import IGListDiffKit

class NewPackExampleModel {
    let images: [String]
    
    init(images: [String]) {
        self.images = images
    }
}

extension NewPackExampleModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return images as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else { return false }
        
        return object.images == images
    }
}
