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
                let ciImage = CIImage(image: fixedImage)
                let features = self.faceDetector.features(in: ciImage!)
                self.completion(fixedImage, features.count > 0)
            }
        }
    }
}
