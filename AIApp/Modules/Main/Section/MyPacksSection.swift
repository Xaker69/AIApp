import UIKit
import IGListKit

class MyPacksSection: ListSectionController {

    let template = MyPacksCell()
    lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
    
    override init() {
        super.init()
        
        supplementaryViewSource = self
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
        
        return configure(cell: cell)
    }
    
    @discardableResult
    private func configure(cell: MyPacksCell) -> MyPacksCell {
        adapter.collectionView = cell.collectionView
        adapter.dataSource = self
        
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
        
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 56.0)
    }
}

// MARK: - ListAdapterDataSource

extension MyPacksSection: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        [MySinglePackModel(name: "mySinglePack")]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MySinglePackSection()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
}
