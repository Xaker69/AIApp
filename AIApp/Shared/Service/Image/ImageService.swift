import UIKit

class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func setImage(from data: Data, to imageView: UIImageView) {
        let cacheKey = NSString(string: String(data.hashValue))
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            imageView.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
}
