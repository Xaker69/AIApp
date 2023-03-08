import Foundation

struct Tune: Codable {
    let id: Int
    let title: String?
    let name: String?
    let isApi: Bool?
    let token: String?
    let baseTuneId: Int?
    let args: [String]?
    let steps: [String]?
    let faceCrop: String?
    let ckptUrl: String?
    let ckptUrls: [String]?
    let trainedAt: String?
    let startedTrainingAt: String?
    let expiresAt: String?
    let createdAt: String?
    let branch: String?
    let updatedAt: String?
    let url: String?
    let origImages: [String]?
    let user: AstriaUser?
    
    enum CodingKeys: String, CodingKey {
        case id, title, name, isApi, token, args, steps, ckptUrl, trainedAt, expiresAt, url
        case baseTuneId = "base_tune_id"
        case faceCrop = "face_crop"
        case ckptUrls = "ckpt_urls"
        case startedTrainingAt = "started_training_at"
        case createdAt = "created_at"
        case branch, updatedAt = "updated_at"
        case origImages = "orig_images"
        case user
    }
}

struct AstriaUser: Codable {
    let createCkpt: Bool?
    
    enum CodingKeys: String, CodingKey {
        case createCkpt = "create_ckpt"
    }
}
