import UIKit

class User: Codable {
    let id: String
    var name: String
    var gender: String
    let photos: [Data]
    var isSelected: Bool
    var packs: [Pack]
    var tune: Tune?
    
    init(id: String, name: String = "", gender: String = "", photos: [Data]) {
        self.id = id
        self.name = name
        self.gender = gender
        self.photos = photos
        
        isSelected = false
        packs = []
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
