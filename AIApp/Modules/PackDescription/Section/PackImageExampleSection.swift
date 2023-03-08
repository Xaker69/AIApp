import IGListKit

class PackImageExampleSection: ListSectionController {
    
    private var model: PackImageExampleModel!
    
    override init() {
        super.init()
        
        supplementaryViewSource = self
        
        inset = UIEdgeInsets(top: 0, left: 40, bottom: 216.0, right: 40)
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is PackImageExampleModel)
        model = object as? PackImageExampleModel
    }
    
    override func numberOfItems() -> Int {
        return model.images.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 40 - 40 - 8)/2, height: 164)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: PackImageExampleCell.self, for: self, at: index)
        
        let imageURL = URL(string: model.images[index])
        cell.imageView.kf.setImage(with: imageURL)
        
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
