import UIKit
import IGListKit
import Alamofire

class UploadingViewController: UIViewController {
    
    var mainView: UploadingView {
        return view as! UploadingView
    }
    
    private lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    private let newPacksModel = PackManager.shared.classPacks.enumerated().map { NewPacksModel(pack: $1, needHeader: $0 == 0) }
    private let pack: Pack
    
    init(pack: Pack) {
        self.pack = pack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let images = Array(UserManager.shared.selectedUser.photos)
        
        PackManager.shared.uploadImage(images: images, for: pack, progress: handleProgress) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.mainView.bottomView.animateCompleteLoad()
                let pack = self.pack.copy()
                pack.isGenerating = true
                
                if UserManager.shared.selectedUser.tune == nil {
                    do {
                        let tune = try JSONDecoder().decode(Tune.self, from: data)
                        UserManager.shared.setTune(tune)
                        print("💙 success load tune \(tune)")
                    } catch {
                        print("❤️ error decode tune \(error)")
                    }
                } else {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let prompt = try decoder.decode(Prompt.self, from: data)
                        pack.prompt = prompt
                        
                        print("💙 success load prompt \(prompt)")
                    } catch {
                        print("❤️ error decode prompt \(error)")
                    }
                }
                
                UserManager.shared.addPack(pack)
                
            case .failure(let error):
                print("❤️ failure complition uploadImage with error:", error)
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
        return newPacksModel
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
    func newPacks(get pack: Pack) {
        
    }
    
    func newPacks(didSelect pack: Pack) {
        
    }
}
