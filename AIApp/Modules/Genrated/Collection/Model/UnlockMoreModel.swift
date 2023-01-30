import IGListDiffKit

class UnlockMoreModel {
    let desctioption: String
    
    init(desctioption: String) {
        self.desctioption = desctioption
    }
}

extension UnlockMoreModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return desctioption as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Self else { return false }
        
        return object.desctioption == desctioption
    }
}
