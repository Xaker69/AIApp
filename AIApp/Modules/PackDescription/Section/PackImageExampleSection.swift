import IGListKit

class PackImageExampleSection: ListSectionController {
    
    override init() {
        super.init()
        
        supplementaryViewSource = self
    }
    
    override func numberOfItems() -> Int {
        return 4
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: PackImageExampleCell.self, for: self, at: index)
        cell.backgroundColor = .gray
        
        return cell
    }
    
}

// MARK: - ListSupplementaryViewSource

extension PackImageExampleSection: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let view = collectionContext!.dequeue(ofKind: UICollectionView.elementKindSectionHeader, for: self, of: PackDescriptionHeaderView.self, at: index)
        
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 112)
    }
}
