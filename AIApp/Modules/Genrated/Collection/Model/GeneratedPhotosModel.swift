import IGListDiffKit

class GeneratedPhotosModel {
    let photos: [UIImage]
    
    init(photos: [UIImage]) {
        self.photos = photos
    }
}

extension GeneratedPhotosModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return photos as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else { return false }
        
        return object.photos == photos
    }
}
