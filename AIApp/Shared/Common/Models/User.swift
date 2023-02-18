import UIKit

class User: Codable {
    let id: String
    let name: String
    let gender: String
    let photos: [Data]
    var isSelected: Bool
    
    init(id: String, name: String, gender: String, photos: [Data]) {
        self.id = id
        self.name = name
        self.gender = gender
        self.photos = photos
        
        isSelected = false
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
