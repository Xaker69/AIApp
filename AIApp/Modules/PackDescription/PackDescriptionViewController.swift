import UIKit
import IGListKit

class PackDescriptionViewController: UIViewController {

    let pack: Pack
    
    var mainView: PackDescriptionView {
        return view as! PackDescriptionView
    }
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    
    init(pack: Pack) {
        self.pack = pack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PackDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.paymentView.getButton.addTarget(self, action: #selector(getButtonTapped), for: .touchUpInside)
        
        adapter.collectionView = mainView.collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func getButtonTapped() {
        let vc = UploadingViewController(pack: pack)
        
        navigationController?.setViewControllers([vc], animated: true)
    }
    
}

// MARK: - ListAdapterDataSource

extension PackDescriptionViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let models: [ListDiffable] = [
            PackDescriptionModel(pack: pack),
            PackImageExampleModel(images: pack.examples)
        ]
        
        return models
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is PackDescriptionModel:
            return PackDescriptionSection()
            
        case is PackImageExampleModel:
            return PackImageExampleSection()
            
        default:
            preconditionFailure("Unknown object type")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - UIScrollViewDelegate

extension PackDescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 464.0 {
            UIView.animate(withDuration: 0.2) {
                self.mainView.paymentView.layer.shadowColor = UIColor.clear.cgColor
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.mainView.paymentView.layer.shadowColor = UIColor(white: 1, alpha: 0.3).cgColor
            }
        }
    }
}
