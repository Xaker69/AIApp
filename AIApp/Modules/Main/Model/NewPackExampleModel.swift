import IGListDiffKit

class NewPackExampleModel {
    let images: [UIImage]
    
    init(images: [UIImage]) {
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
