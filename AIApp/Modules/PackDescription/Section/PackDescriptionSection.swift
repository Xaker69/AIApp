import IGListKit

class PackDescriptionSection: ListSectionController {
    
    override init() {
        super.init()
        
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: PackImageExampleCell.self, for: self, at: index)
        
        
        return cell
    }
    
}
