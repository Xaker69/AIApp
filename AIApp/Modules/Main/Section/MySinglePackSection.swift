import IGListKit

class MySinglePackSection: ListSectionController {
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        minimumLineSpacing = 8.0
    }
    
    override func numberOfItems() -> Int {
        return 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 165.0, height: 198.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: MySinglePackCell.self, for: self, at: index)
        cell.imageView.image = R.image.oilExample()
        
        return cell
    }
    
}
