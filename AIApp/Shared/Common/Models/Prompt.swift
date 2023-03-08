import UIKit

struct Prompt: Codable {
    let createdAt: String?
    let id: Int
    let images: [String]?
    let negativePrompt: String?
    let startedTrainingAt: String?
    let steps: String?
    let text: String?
    let trainedAt: String?
    let tuneId: Int
    let updatedAt: String?
}
