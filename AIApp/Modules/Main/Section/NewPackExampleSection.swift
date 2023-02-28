import IGListKit

protocol NewPackExampleDelegate: AnyObject {
    func newPackExample(didSelect index: Int)
}

class NewPackExampleSection: ListSectionController {
    
    var model: NewPackExampleModel!
    
    weak var delegate: NewPackExampleDelegate?
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        minimumLineSpacing = 5
    }
    
    override func numberOfItems() -> Int {
        return model.images.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 120.0, height: 138.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: NewPackExampleCell.self, for: self, at: index)
        
        cell.imageView.kf.setImage(with: model.images[index])
        
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        delegate?.newPackExample(didSelect: index)
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is NewPackExampleModel)
        model = object as? NewPackExampleModel
    }
    
}
