import PhotosUI

class DownloadOperation: Operation {
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
                let ciImage = CIImage(image: photo)
                let features = self.faceDetector.features(in: ciImage!)
                self.completion(photo, features.count > 0)
            }
        }
    }
}
