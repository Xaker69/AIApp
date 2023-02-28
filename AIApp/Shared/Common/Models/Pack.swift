import Foundation

class Pack: Codable {
    let name: String
    let promts: String
    let description: String
    let examples: [URL]
    let previewImage: URL?
    var isGenerating: Bool
    
    init(name: String, promts: String, description: String, examples: [URL], previewImage: URL?, isGenerating: Bool = false) {
        self.name = name
        self.promts = promts
        self.description = description
        self.examples = examples
        self.previewImage = previewImage
        self.isGenerating = isGenerating
    }
}

extension Pack: Equatable {
    static func == (lhs: Pack, rhs: Pack) -> Bool {
        return lhs.name == rhs.name
    }
}
