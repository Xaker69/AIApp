import UIKit

class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static private let cacheQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).imageCache")
    static private let decodeQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).imageDecode", attributes: .concurrent)
    
    static func setImage(from data: Data, to imageView: UIImageView) {
        let cacheKey = NSString(string: String(data.hashValue))
        
//        if let cachedImage = cache.object(forKey: cacheKey) {
//            imageView.image = cachedImage
//            return
//        }
        
        decodeQueue.async {
            if let image = UIImage(data: data) {
//                cacheQueue.async {
//                    cache.setObject(image, forKey: cacheKey)
//                }
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
}
