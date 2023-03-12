import UIKit
import IGListKit

class GeneratedPackViewController: UIViewController {

    var mainView: GeneratedPackView {
        return view as! GeneratedPackView
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
        view = GeneratedPackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.titleLabel.text = pack.name
        
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        
        setupCloseButton()
    }
    
    @objc private func closeButtonTapped() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
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

extension GeneratedPackViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            GeneratedPackModel(pack: pack),
            UnlockMoreModel(desctioption: "UnlockMoreModel")
        ]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is GeneratedPackModel:
            let section = GeneratedPackSection()
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

extension GeneratedPackViewController: GeneratedPackDelegate {
    func generatedPack(_ controller: GeneratedPackSection, didSelect index: Int) {        
        let vc = GeneratedPhotoViewController(startIndex: index, pack: pack)
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}
