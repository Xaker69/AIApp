import UIKit

struct User: Codable {
    let id: String
    let name: String
    let gender: String
    let photos: [Data]
}

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
