import UIKit
import IGListKit

protocol ProfileSectionDelegate: AnyObject {
    func profileSection(_ controller: ProfilesSection, didSelect person: Person?)
}

class ProfilesSection: ListSectionController {

    let template = ProfilesCell()
    lazy var adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: viewController)
    
    var model: ProfilesModel!
    
    weak var delegate: ProfileSectionDelegate?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let size = CGSize(width: collectionContext!.containerSize.width, height: 80 + 16 + 16)
        
        return size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: ProfilesCell.self, for: self, at: index)
        
        return configure(cell: cell)
    }
    
    @discardableResult
    private func configure(cell: ProfilesCell) -> ProfilesCell {
        adapter.collectionView = cell.collectionView
        adapter.dataSource = self
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is ProfilesModel)
        model = object as? ProfilesModel
    }
    
}

// MARK: - ListAdapterDataSource

extension ProfilesSection: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects = model.persons.map { SingleProfileModel(person: $0) }
        objects.append(SingleProfileModel(person: nil))
        
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let section = SingleProfileSection()
        section.delegate = self
        
        return section
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
}

// MARK: - SingleProfileDelegate

extension ProfilesSection: SingleProfileDelegate {
    func singleProfile(_ section: SingleProfileSection, person: Person?) {
        delegate?.profileSection(self, didSelect: person)
    }
}
