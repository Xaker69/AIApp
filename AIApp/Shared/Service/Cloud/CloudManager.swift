import FirebaseStorage
import FirebaseFirestore

class CloudManager {
    
    enum ImageName: String {
        case onboardingImage = "/OnboardingImage"
        case preview = "/Preview"
        case firstExample = "/Example-1"
        case secondExample = "/Example-2"
        case thirdExample = "/Example-3"
        case fourthExample = "/Example-4"
    }
    
    static var shared = CloudManager()
    
    private let storage = Storage.storage(url: "gs://lensa-ai-app.appspot.com")
    private let db = Firestore.firestore()
    
    private(set) var packs = [Pack]()
    
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
                
                guard
                    let packName = document.data()["name"] as? String,
                    let packPrompts = document.data()["prompts"] as? String,
                    let packDescription = document.data()["description"] as? String
                else { return }
                
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
                
                documentGroup.notify(queue: .main) {
                    let pack = Pack(
                        name: packName,
                        promts: packPrompts,
                        description: packDescription,
                        examples: packExamples,
                        previewImage: packPreviewImage
                    )
                    
                    self.packs.append(pack)
                    collectionGroup.leave()
                }
            }
            
            collectionGroup.notify(queue: .main) {
                NotificationCenter.default.post(name: .packsDidLoaded, object: nil)
            }
        }
    }
}
