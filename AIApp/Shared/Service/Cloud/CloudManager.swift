import FirebaseStorage
import FirebaseFirestore
import Alamofire

class CloudManager {
    
    enum ImageName: String {
        case onboardingImage = "/OnboardingImage"
        case preview = "/Preview.png"
        case firstExample = "/Example-1.png"
        case secondExample = "/Example-2.png"
        case thirdExample = "/Example-3.png"
        case fourthExample = "/Example-4.png"
    }
    
    static var shared = CloudManager()
    
    private let storage = Storage.storage(url: "gs://lensa-ai-app.appspot.com")
    private let db = Firestore.firestore()
    private let apiKey = "sd_eda1h1G19zmkSwsb9gqRYkc3tHiKix"
    
    private(set) var allPacks = [Pack]()
    
    var classPacks: [Pack] {
        return allPacks.filter { $0.className == UserManager.shared.selectedUser.gender }
    }
    
    func getImageUrl(for name: ImageName, folder path: String = "", completion: @escaping (URL?) -> Void) {
        let storageRef = storage.reference(withPath: path + name.rawValue)
        
        storageRef.downloadURL { url, erorr in
            if let error = erorr {
                print("❤️ Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let url = url else {
                print("❤️ URL not valid")
                completion(nil)
                return
            }
            
            completion(url)
        }
    }
    
    func loadPacks() {
        db.collection("Packs").getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("❤️ Error getting documents: \(error)")
                return
            }
            
            let collectionGroup = DispatchGroup()
            
            for document in querySnapshot!.documents {
                collectionGroup.enter()
                let documentGroup = DispatchGroup()
                let folder = "Packs/\(document.documentID)"
                
                var packExamples: [URL] = []
                var packPreviewImage: URL?
                
                documentGroup.enter()
                self.getImageUrl(for: .preview, folder: folder) { previewURL in
                    defer { documentGroup.leave() }
                    guard let previewURL = previewURL else { return }
                    packPreviewImage = previewURL
                }
                
                documentGroup.enter()
                self.getImageUrl(for: .firstExample, folder: folder) { firstURL in
                    defer { documentGroup.leave() }
                    guard let firstURL = firstURL else { return }
                    packExamples.append(firstURL)
                }
                
                documentGroup.enter()
                self.getImageUrl(for: .secondExample, folder: folder) { secURL in
                    defer { documentGroup.leave() }
                    guard let secURL = secURL else { return }
                    packExamples.append(secURL)
                }
                
                documentGroup.enter()
                self.getImageUrl(for: .thirdExample, folder: folder) { thirdURL in
                    defer { documentGroup.leave() }
                    guard let thirdURL = thirdURL else { return }
                    packExamples.append(thirdURL)
                }
                
                documentGroup.enter()
                self.getImageUrl(for: .fourthExample, folder: folder) { fourthURL in
                    defer { documentGroup.leave() }
                    guard let fourthURL = fourthURL else { return }
                    packExamples.append(fourthURL)
                }
                
                documentGroup.notify(queue: .global(qos: .userInteractive)) {
                    var tmpData = document.data()
                    tmpData["examples"] = packExamples.compactMap { $0.description }
                    
                    if let packPreviewImage = packPreviewImage {
                        tmpData["previewImage"] = packPreviewImage.description
                    }
                    
                    let pack = Pack(json: tmpData)
                    
                    self.allPacks.append(pack)
                    
                    collectionGroup.leave()
                }
            }
            
            collectionGroup.notify(queue: .main) {
                NotificationCenter.default.post(name: .packsDidLoaded, object: nil)
            }
        }
    }
    
    func uploadImage(images: [Data], for pack: Pack, progress handler: @escaping Request.ProgressHandler, completion: @escaping (Result<Data, Error>) -> Void) {
        let DOMAIN = "https://api.astria.ai"
        let url: URL
        let title = "\(UserManager.shared.selectedUser.name).\(UserManager.shared.selectedUser.id)".data(using: .utf8)!
        let branch = "fast".data(using: .utf8)!
        let token = "sks".data(using: .utf8)!
        let name = UserManager.shared.selectedUser.gender.data(using: .utf8)!
        let prompts = pack.prompts.data(using: .utf8)!
        let negativePrompts = pack.negativePrompts.data(using: .utf8)!
        let seed = pack.seed.description.data(using: .utf8)!
        let formData = MultipartFormData()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + apiKey
        ]
        
        if let tune = UserManager.shared.selectedUser.tune {
            url = URL(string: DOMAIN + "/tunes/\(tune.id)/prompts")!
            
            formData.append(prompts, withName: "prompt[text]")
            formData.append(negativePrompts, withName: "prompt[negative_prompt]")
            formData.append(seed, withName: "prompt[seed]")
            
            if let deviceToken = UserSettings.deviceToken {
                let callback = "https://us-central1-lensa-ai-app.cloudfunctions.net/apn?deviceToken=\(deviceToken)"
                formData.append(callback.data(using: .utf8)!, withName: "prompt[callback]")
            }
        } else {
            url = URL(string: DOMAIN + "/tunes")!
            
            formData.append(title, withName: "tune[title]")
            formData.append(branch, withName: "tune[branch]")
            formData.append(token, withName: "tune[token]")
            formData.append(name, withName: "tune[name]")
            formData.append(prompts, withName: "tune[prompts_attributes][0][text]")
            formData.append(negativePrompts, withName: "tune[prompts_attributes][0][negative_prompt]")
            formData.append(seed, withName: "tune[prompts_attributes][0][seed]")
            
            for image in images {
                let filename = image.hashValue.description
                let mimetype = "image/jpeg"
                
                formData.append(image, withName: "tune[images][]", fileName: filename, mimeType: mimetype)
            }
            
            if let deviceToken = UserSettings.deviceToken {
                let callback = "https://us-central1-lensa-ai-app.cloudfunctions.net/apn?deviceToken=\(deviceToken)"
                formData.append(callback.data(using: .utf8)!, withName: "tune[prompts_attributes][0][callback]")
            }
        }
        
        AF.upload(multipartFormData: formData, to: url, method: .post, headers: headers)
            .uploadProgress(closure: handler)
            .responseData { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
