import AWSS3
import FirebaseStorage

class CloudManager {
    
    enum ImageName: String {
        case onboardingImage = "/photo_2022-12-07 23.21.28.jpeg"
    }
    
    static var shared = CloudManager()
    
    private let storage = Storage.storage(url: "gs://lensa-ai-app.appspot.com")
    
    func getImageUrl(for name: ImageName, completion: @escaping (URL?) -> Void) {
        let storageRef = storage.reference(withPath: name.rawValue)
        
        //for use placeholder
        completion(nil)
        
        storageRef.downloadURL { url, erorr in
            if let error = erorr {
                print("❤️‍🩹 Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let url = url else {
                print("❤️‍🩹 URL not valid")
                completion(nil)
                return
            }
            
            completion(url)
        }
    }
    
}
