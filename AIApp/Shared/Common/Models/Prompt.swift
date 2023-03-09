import UIKit

class Prompt: Codable {
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
    
    init(json: [String: Any]) {
        self.createdAt = json["created_at"] as? String
        self.id = json["id"] as! Int
        self.images = json["images"] as? [String]
        self.negativePrompt = json["negative_prompt"] as? String
        self.startedTrainingAt = json["started_training_at"] as? String
        self.steps = json["steps"] as? String
        self.text = json["text"] as? String
        self.trainedAt = json["trained_at"] as? String
        self.tuneId = json["tune_id"] as! Int
        self.updatedAt = json["updated_at"] as? String
    }
}
