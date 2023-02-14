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

        UIApplication.shared.registerForRemoteNotifications()
        UNUserNotificationCenter.current().requestAuthorization { bool, error in
            print("💙 bool: \(bool) , error: \(error)")
        }
        
        //        let images = Array(PersonManager.shared.getPersons()![0].photos)
//        uploadImage(images: images.compactMap { UIImage(data: $0 ?? Data()) }, apiKey: "sd_eda1h1G19zmkSwsb9gqRYkc3tHiKix") { result in
//            switch result {
//            case .success(let data):
//                guard let data = data else {
//                    print("❤️ success completion uploadImage with wrong data DATA IS NILL")
//                    return
//                }
////                let json = try! JSONSerialization.jsonObject(with: data)
//                print("💙 success complition with json:", data)
//
//            case .failure(let error):
//                print("❤️ failure complition uploadImage with error:", error)
//            }
//        }
    }
    
    @objc private func continueButtonTapped() {
        let vc = AttentionViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }
    
    func uploadImage(images: [UIImage], apiKey: String, completion: @escaping (Result<String?, Error>) -> Void) {
        print("💚 images count", images.count)
        let url = "https://api.astria.ai/tunes"

            let parameters: [String: Any] = [
                "tune": [
                    "name": "man",
                    "branch": "fast",
                    "title": "muscle man",
                    "prompts_attributes": [
                        [
                            "text": "zwx muscle man in dubai"
                        ],
                        [
                            "text": "zwx short hair man in smoking at the table with cigarette"
                        ]
                    ]
                ]
            ]

            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(apiKey)",
                "Content-Type": "multipart/data"
            ]
        
        AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
                for (index, image) in images.enumerated() {
                    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                        return
                    }
                    multipartFormData.append(imageData, withName: "tune[images][\(index)]", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            }, to: url, headers: headers).responseString { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
}
