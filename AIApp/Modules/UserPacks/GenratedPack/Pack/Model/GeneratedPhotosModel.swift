import IGListDiffKit

class GeneratedPackModel {
    let pack: Pack
    
    init(pack: Pack) {
        self.pack = pack
    }
}

extension GeneratedPackModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return pack.name as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else { return false }
        
        return object.pack == pack
    }
}
