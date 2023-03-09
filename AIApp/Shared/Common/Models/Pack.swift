import Foundation

class Pack: Codable {
    let name: String
    let prompts: String
    let description: String
    let className: String
    let imageNumber: Int
    let negativePrompts: String
    let previewDescription: String
    let seed: Int
    let tags: String
    let examples: [String]
    let previewImage: String
    
    var isGenerating: Bool
    var prompt: Prompt?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.prompts = try container.decodeIfPresent(String.self, forKey: .prompts) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.examples = try container.decodeIfPresent([String].self, forKey: .examples) ?? []
        self.previewImage = try container.decodeIfPresent(String.self, forKey: .previewImage) ?? ""
        self.className = try container.decodeIfPresent(String.self, forKey: .className) ?? ""
        self.imageNumber = try container.decodeIfPresent(Int.self, forKey: .imageNumber) ?? -1
        self.negativePrompts = try container.decodeIfPresent(String.self, forKey: .negativePrompts) ?? ""
        self.previewDescription = try container.decodeIfPresent(String.self, forKey: .previewDescription) ?? ""
        self.seed = try container.decodeIfPresent(Int.self, forKey: .seed) ?? -1
        self.tags = try container.decodeIfPresent(String.self, forKey: .tags) ?? ""
        self.isGenerating = try container.decodeIfPresent(Bool.self, forKey: .isGenerating) ?? false
        self.prompt = try container.decodeIfPresent(Prompt.self, forKey: .prompt)
    }
    
    init(json: [String: Any]) {
        self.name = json[CodingKeys.name.rawValue] as? String ?? ""
        self.prompts = json[CodingKeys.prompts.rawValue] as? String ?? ""
        self.description = json[CodingKeys.description.rawValue] as? String ?? ""
        self.examples = json[CodingKeys.examples.rawValue] as? [String] ?? []
        self.previewImage = json[CodingKeys.previewImage.rawValue] as? String ?? ""
        self.className = json[CodingKeys.className.rawValue] as? String ?? ""
        self.imageNumber = json[CodingKeys.imageNumber.rawValue] as? Int ?? -1
        self.negativePrompts = json[CodingKeys.negativePrompts.rawValue] as? String ?? ""
        self.previewDescription = json[CodingKeys.previewDescription.rawValue] as? String ?? ""
        self.seed = json[CodingKeys.seed.rawValue] as? Int ?? -1
        self.tags = json[CodingKeys.tags.rawValue] as? String ?? ""
        self.isGenerating = json[CodingKeys.isGenerating.rawValue] as? Bool ?? false
    }
    
    private init(name: String, prompts: String, description: String, className: String, imageNumber: Int, negativePrompts: String, previewDescription: String, seed: Int, tags: String, isGenerating: Bool, examples: [String], previewImage: String) {
        self.name = name
        self.prompts = prompts
        self.description = description
        self.className = className
        self.imageNumber = imageNumber
        self.negativePrompts = negativePrompts
        self.previewDescription = previewDescription
        self.seed = seed
        self.tags = tags
        self.isGenerating = isGenerating
        self.examples = examples
        self.previewImage = previewImage
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case prompts
        case description
        case examples
        case previewImage
        case className = "class"
        case imageNumber = "img_numb"
        case negativePrompts = "negative"
        case previewDescription = "preview_description"
        case seed
        case tags
        case isGenerating
        case prompt
    }
    
    func copy() -> Pack {
        return Pack(name: name, prompts: prompts, description: description, className: className, imageNumber: imageNumber, negativePrompts: negativePrompts, previewDescription: previewDescription, seed: seed, tags: tags, isGenerating: isGenerating, examples: examples, previewImage: previewImage)
    }
}

extension Pack: Equatable {
    static func == (lhs: Pack, rhs: Pack) -> Bool {
        return lhs.name == rhs.name
    }
}
