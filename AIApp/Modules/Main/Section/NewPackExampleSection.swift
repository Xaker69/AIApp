import IGListKit

class NewPackExampleSection: ListSectionController {
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        minimumLineSpacing = 5
    }
    
    override func numberOfItems() -> Int {
        return 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 120.0, height: 138.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: NewPackExampleCell.self, for: self, at: index)
        cell.imageView.image = R.image.newPackExample()
        
        return cell
    }
    
}