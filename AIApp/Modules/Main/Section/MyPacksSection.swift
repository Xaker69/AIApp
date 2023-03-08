import UIKit
import IGListKit

protocol MyPacksDelegate: AnyObject {
    func myPacks(_ section: MyPacksSection, didSelect pack: Pack)
    func myPacks(needShowAllPacks section: MyPacksSection)
}

class MyPacksSection: ListSectionController {

    weak var delegate: MyPacksDelegate?
    var model: MyPacksModel!
    
    let template = MyPacksCell()
    lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
    
    override init() {
        super.init()
        
        supplementaryViewSource = self
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is MyPacksModel)
        model = object as? MyPacksModel
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
        
    override func sizeForItem(at index: Int) -> CGSize {
        let size = CGSize(width: collectionContext!.containerSize.width, height: CGFloat.greatestFiniteMagnitude)
        configure(cell: template)
        template.frame.size = size
        template.layoutIfNeeded()
        
        return template.systemLayoutSizeFitting(size)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: MyPacksCell.self, for: self, at: index)
        
        adapter.collectionView = cell.collectionView
        adapter.dataSource = self
        
        return configure(cell: cell)
    }
    
    @objc private func seeAllButtonTapped() {
        delegate?.myPacks(needShowAllPacks: self)
    }
    
    @discardableResult
    private func configure(cell: MyPacksCell) -> MyPacksCell {
        return cell
    }
}

// MARK: - ListSupplementaryViewSource

extension MyPacksSection: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let view = collectionContext!.dequeue(ofKind: UICollectionView.elementKindSectionHeader, for: self, of: MainHeaderView.self, at: index)
        view.titleLabel.text = R.string.localizable.mainHeaderMyPacks()
        view.rightButton.isHidden = false
        view.rightButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 56.0)
    }
}

// MARK: - ListAdapterDataSource

extension MyPacksSection: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [MySinglePackModel(packs: model.user.packs)]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = MySinglePackSection(direction: .horizontal)
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: - MySinglePackDelegate

extension MyPacksSection: MySinglePackDelegate {
    func mySinglePack(_ section: MySinglePackSection, didSelect pack: Pack) {
        delegate?.myPacks(self, didSelect: pack)
    }
}
