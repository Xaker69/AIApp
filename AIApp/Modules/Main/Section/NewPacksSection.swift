import UIKit
import IGListKit

protocol NewPacksDelegate: AnyObject {
    func newPacks(get pack: Pack)
    func newPacks(didSelect pack: Pack)
}

class NewPacksSection: ListSectionController {

    enum HeaderType {
        case oneTimeOffer
        case title
    }
    
    let template = NewPackCell()
    let headerType: HeaderType
    var model: NewPacksModel!
    
    weak var delegate: NewPacksDelegate?
    
    private lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
    
    init(headerType: HeaderType) {
        self.headerType = headerType
        super.init()
        
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is NewPacksModel)
        model = object as? NewPacksModel
        
        if model.needHeader {
            supplementaryViewSource = self
        }
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = CGSize(width: collectionContext!.containerSize.width, height: CGFloat.greatestFiniteMagnitude)
        configure(cell: template)
        template.frame.size = size
        template.layoutIfNeeded()
        
        return template.systemLayoutSizeFitting(size)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: NewPackCell.self, for: self, at: index)
        
        adapter.collectionView = cell.collectionView
        adapter.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(getPackTapped))
        cell.getContainer.addGestureRecognizer(gesture)
        cell.getContainer.tag = index
        
        return configure(cell: cell)
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.newPacks(didSelect: model.pack)
    }
    
    // MARK: - Private actions
    
    @objc private func getPackTapped(_ sender: UITapGestureRecognizer) {
        delegate?.newPacks(get: model.pack)
    }
    
    // MARK: - Private methods
    
    @discardableResult
    private func configure(cell: NewPackCell) -> NewPackCell {
        cell.titleLabel.text = model.pack.name
        cell.picsLabel.text = R.string.localizable.mainNewPackImageCount(model.pack.imageNumber.description)
        
        return cell
    }
    
}

// MARK: - ListSupplementaryViewSource

extension NewPacksSection: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch headerType {
        case .title:
            let view = collectionContext!.dequeue(ofKind: UICollectionView.elementKindSectionHeader, for: self, of: MainHeaderView.self, at: index)
            view.titleLabel.text = R.string.localizable.mainHeaderExplore()
            view.rightButton.isHidden = true
            
            return view
            
        case .oneTimeOffer:
            return collectionContext!.dequeue(ofKind: UICollectionView.elementKindSectionHeader, for: self, of: OfferHeaderView.self, at: index)
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        let template: UIView
        let size = CGSize(width: collectionContext!.containerSize.width, height: CGFloat.greatestFiniteMagnitude)
        
        switch headerType {
        case .oneTimeOffer:
            template = OfferHeaderView()
            
        case .title:
            let tmp = MainHeaderView()
            tmp.titleLabel.text = R.string.localizable.mainHeaderExplore()
            template = tmp
        }
        
        template.frame.size = size
        template.layoutIfNeeded()
        
        return template.systemLayoutSizeFitting(size)
    }
    
}

// MARK: - ListAdapterDataSource

extension NewPacksSection: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [NewPackExampleModel(images: model.pack.examples)]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = NewPackExampleSection()
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
}

// MARK: - NewPackExampleDelegate

extension NewPacksSection: NewPackExampleDelegate {
    func newPackExample(didSelect index: Int) {
        delegate?.newPacks(didSelect: model.pack)
    }
}
