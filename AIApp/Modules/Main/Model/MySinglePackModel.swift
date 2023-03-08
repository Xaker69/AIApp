import IGListDiffKit

class MySinglePackModel {
    let packs: [Pack]
    
    init(packs: [Pack]) {
        self.packs = packs
    }
}

extension MySinglePackModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return packs as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else {
            return false
        }
        
        return object.packs == packs
    }
}
