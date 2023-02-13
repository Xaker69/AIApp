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
    }
    
    @objc private func continueButtonTapped() {
        let vc = AttentionViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }
    
    private func testAlamofire() {
        let apiKey = "your_api_key_here"
        let url = "https://api.astria.ai/tunes"

        let parameters: [String: Any] = [
          "tune": [
            "name": "cat",
            "branch": "fast",
            "image_urls": [
              "https://i.imgur.com/HLHBnl9.jpeg",
              "https://i.imgur.com/HLHBnl9.jpeg",
              "https://i.imgur.com/HLHBnl9.jpeg",
              "https://i.imgur.com/HLHBnl9.jpeg"
            ],
            "title": "grumpy cat",
            "prompts_attributes": [
              [
                "text": "zwx cat in space circa 1979 French illustration"
              ],
              [
                "text": "zwx cat getting into trouble viral meme"
              ]
            ]
          ]
        ]

        let headers: HTTPHeaders = [
          "Authorization": "Bearer \(apiKey)",
          "Content-Type": "application/json"
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
          .responseJSON { response in
            switch response.result {
            case .success(let value):
              print("Success: \(value)")
            case .failure(let error):
              print("Error: \(error)")
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
