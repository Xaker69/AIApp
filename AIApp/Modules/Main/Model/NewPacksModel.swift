import IGListDiffKit

class NewPacksModel {
    let pack: Pack
    let needHeader: Bool
    
    init(pack: Pack, needHeader: Bool) {
        self.pack = pack
        self.needHeader = needHeader
    }
}

extension NewPacksModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return pack.name as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.pack == pack
    }
}

