import UIKit
import SafariServices
import PhotosUI

class UploadPhotosViewController: UIViewController {
    
    var queue = OperationQueue()
    var operations = [ImageDownloader]()
    
    var mainView: UploadPhotosView {
        return view as! UploadPhotosView
    }
    
    override func loadView() {
        view = UploadPhotosView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.boxButton.addTarget(self, action: #selector(boxButtonTapped), for: .touchUpInside)
        mainView.uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        
        mainView.picker.delegate = self
        
        setupClicablePrivacy()
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func boxButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        mainView.uploadButton.isEnabled.toggle()
        
        mainView.uploadButton.alpha = mainView.uploadButton.isEnabled ? 1.0 : 0.1
    }
    
    @objc private func uploadButtonTapped() {
        present(mainView.picker, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func setupClicablePrivacy() {
        mainView.privacyLabel.onClick = { [weak self] label, detection in
            switch detection.type {
            case let .tag(tag):
                if let href = tag.attributes["href"], let url = URL(string: href) {
                    self?.present(SFSafariViewController(url: url), animated: true)
                }
            default:
                break
            }
        }
    }
    
    private func dowloadPhotos(from results: [PHPickerResult]) {
        if results.count < 15 {
            showNotEnoughAlert(notDetectedIDs: nil, results: nil)
        } else {
            let alert = UIAlertController(title: "Importing photos...", message: "0/\(results.count)", preferredStyle: .alert)
            alert.overrideUserInterfaceStyle = .dark
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
                if #available(iOS 16, *) {
                    let identifiers = results.compactMap { $0.assetIdentifier }
                    self.mainView.picker.deselectAssets(withIdentifiers: identifiers)
                }
                
                self.cancelDownload()
            }
            
            cancelAction.setValue(UIColor.white, forKey: "titleTextColor")
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
            
            let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
            var loadedCount = 0
            var notDetectedIds = [String]()
            var detectedImages = [UIImage]()
            
            results.forEach { result in
                let operation = ImageDownloader(result: result, faceDetector: faceDetector) { photo, isDetected in
                    DispatchQueue.main.async {
                        if let photo = photo, isDetected {
                            detectedImages.append(photo)
                        } else if let id = result.assetIdentifier {
                            notDetectedIds.append(id)
                        }
                        
                        loadedCount += 1
                        alert.message = "\(loadedCount)/\(results.count)"
                        
                        if results.count == loadedCount {
                            alert.dismiss(animated: true) {
                                self.cancelDownload()
                                
                                if detectedImages.count >= 15 {
                                    print("💙 dtected images count:", detectedImages.count)
                                    self.photosDowloaded(detectedImages)
                                } else {
                                    self.showNotEnoughAlert(notDetectedIDs: notDetectedIds, results: results.count)
                                }
                            }
                        }
                    }
                }
                
                operations.append(operation)
            }
            
            queue.addOperations(operations, waitUntilFinished: false)
        }
    }
    
    private func showNotEnoughAlert(notDetectedIDs: [String]?, results count: Int?) {
        let alert = UIAlertController(title: "Not enough photos", message: "", preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = .dark
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        cancelAction.setValue(UIColor.white, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        
        if let notDetectedIDs = notDetectedIDs, let count = count {
            alert.message = "\(notDetectedIDs.count) of \(count) photos you’ve selected are not meet the requirements"
            
            let selectAction = UIAlertAction(title: "Select more photos", style: .cancel) { action in
                if #available(iOS 16, *) {
                    self.mainView.picker.deselectAssets(withIdentifiers: notDetectedIDs)
                }
                
                alert.dismiss(animated: true) {
                    self.present(self.mainView.picker, animated: true)
                }
            }
            
            selectAction.setValue(UIColor.white, forKey: "titleTextColor")
            alert.addAction(selectAction)
            
            present(alert, animated: true)
        } else {
            alert.message = "Please upload at least 15 photos"
            
            let selectAction = UIAlertAction(title: "Select more photos", style: .cancel) { action in
                alert.dismiss(animated: true) {
                    self.present(self.mainView.picker, animated: true)
                }
            }
            
            selectAction.setValue(UIColor.white, forKey: "titleTextColor")
            alert.addAction(selectAction)
            
            present(alert, animated: true)
        }
    }
    
    private func cancelDownload() {
        operations.forEach { $0.cancel() }
        operations.removeAll()
    }
    
    private func photosDowloaded(_ photos: [UIImage]) {
        let photosData = photos.compactMap { $0.jpegData(compressionQuality: 0.5) }
        UserManager.shared.createUser(photos: photosData)
        let vc = SelectGenderViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - PHPickerViewControllerDelegate

extension UploadPhotosViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) {
            self.dowloadPhotos(from: results)
        }
    }
}
