import PhotosUI

class ImageDownloader: Operation {
    let result: PHPickerResult
    let faceDetector: CIDetector
    let completion: (UIImage?, Bool) -> Void
    
    init(result: PHPickerResult, faceDetector: CIDetector, completion: @escaping (UIImage?, Bool) -> Void) {
        self.result = result
        self.faceDetector = faceDetector
        self.completion = completion
    }
    
    override func main() {
        if isCancelled { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] item, error in
            guard let self = self, !self.isCancelled else { return }
            
            if let photo = item as? UIImage {
                let fixedImage = photo.fixOrientation()
                print("💙 image orentation: ", fixedImage.imageOrientation.rawValue)
                let ciImage = CIImage(image: fixedImage)
                let features = self.faceDetector.features(in: ciImage!)
                self.completion(fixedImage, features.count > 0)
            }
        }
    }
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let fixedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return fixedImage!
    }
}
