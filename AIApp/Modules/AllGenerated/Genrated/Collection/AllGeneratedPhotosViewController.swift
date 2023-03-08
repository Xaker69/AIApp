import UIKit
import IGListKit

class AllGeneratedPhotosViewController: UIViewController {

    var mainView: AllGeneratedPhotosView {
        return view as! AllGeneratedPhotosView
    }
    
    private lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    private let pack: Pack
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(pack: Pack) {
        self.pack = pack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AllGeneratedPhotosView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        
        setupCloseButton()
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupCloseButton() {
        if navigationController != nil {
            mainView.closeButton.setImage(R.image.back(), for: .normal)
        } else {
            mainView.closeButton.setImage(R.image.close(), for: .normal)
        }
    }
}

// MARK: - ListAdapterDataSource

extension AllGeneratedPhotosViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            GeneratedPhotosModel(photos: pack.prompt?.images ?? []),
            UnlockMoreModel(desctioption: "UnlockMoreModel")
        ]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is GeneratedPhotosModel:
            let section = GeneratedPhotosSection()
            section.delegate = self
            
            return section
            
        case is UnlockMoreModel:
            return UnlockMoreSection()
            
        default:
            preconditionFailure("Unknown object type")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension AllGeneratedPhotosViewController: GeneratedPhotosDelegate {
    func generatedPhotos(_ controller: GeneratedPhotosSection, didSelect index: Int) {
        let count = pack.prompt?.images?.count ?? 0
        let photos = pack.prompt?.images ?? []
        
        let vc = SingleGeneratedPhotoViewController(startIndex: index, count: count, photos: photos)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}
