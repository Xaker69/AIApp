import UIKit
import IGListKit
import Alamofire

class UploadingViewController: UIViewController {
    
    var mainView: UploadingView {
        return view as! UploadingView
    }
    
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    override func loadView() {
        view = UploadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.bottomView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
              
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        uploadPhotos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc private func continueButtonTapped() {
        let vc = AttentionViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.dismissCompletion = { [weak self] in
            self?.navigationController?.setViewControllers([MainViewController()], animated: true)
        }
        
        present(vc, animated: true)
    }
    
    private func uploadPhotos() {
        let images = Array(UserManager.shared.users[0].photos)
        let apiKey = "sd_eda1h1G19zmkSwsb9gqRYkc3tHiKix"
        
        uploadImage(images: images, apiKey: apiKey) { result in
            switch result {
            case .success(let data):
                self.mainView.bottomView.animateCompleteLoad()
                print("💙 success complition with json:", data)

            case .failure(let error):
                print("❤️ failure complition uploadImage with error:", error)
            }
        }
    }
    
    private func uploadImage(images: [Data], apiKey: String, completion: @escaping (Result<String, Error>) -> Void) {
        print("💛 photos count", images.count)
        let DOMAIN = "https://api.astria.ai"
        let url = URL(string: DOMAIN + "/tunes")!

        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + apiKey
        ]

        let boundary = "Boundary-\(UUID().uuidString)"
        let formData = MultipartFormData()
        formData.append("TEST".data(using: .utf8)!, withName: "tune[title]")
        formData.append("fast".data(using: .utf8)!, withName: "tune[branch]")
        formData.append("zwx".data(using: .utf8)!, withName: "tune[token]")
        formData.append("man".data(using: .utf8)!, withName: "tune[name]")

        for image in images {
            let filename = image.hashValue.description
            let mimetype = "image/jpeg"
            
            formData.append(image, withName: "tune[images][]", fileName: filename, mimeType: mimetype)
        }

        if let deviceToken = UserSettings.deviceToken {
            let callback = "https://us-central1-lensa-ai-app.cloudfunctions.net/apn?deviceToken=\(deviceToken)"
            formData.append(callback.data(using: .utf8)!, withName: "tune[callback]")
        }

        AF.upload(multipartFormData: formData, to: url, method: .post, headers: headers)
            .uploadProgress(closure: handleProgress)
            .responseString { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private func handleProgress(_ progress: Progress) {
        mainView.bottomView.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
    }
}

// MARK: - ListAdapterDataSource

extension UploadingViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [NewPacksModel(name: "morePacks")]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = NewPacksSection(headerType: .oneTimeOffer)
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - NewPacksDelegate

extension UploadingViewController: NewPacksDelegate {
    func newPacks(getPack index: Int) {
        
    }
    
    func newPacks(didSelect index: Int) {
        
    }
}
