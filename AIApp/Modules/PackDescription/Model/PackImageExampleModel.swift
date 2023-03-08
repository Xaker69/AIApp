import IGListDiffKit

class PackImageExampleModel {
    let images: [String]
    
    init(images: [String]) {
        self.images = images
    }
}

extension PackImageExampleModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return images as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.images == images
    }
}
