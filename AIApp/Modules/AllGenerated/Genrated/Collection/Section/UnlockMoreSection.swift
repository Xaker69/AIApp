import IGListKit

class UnlockMoreSection: ListSectionController {
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 56.0 + 16.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeue(of: UnlockMoreCell.self, for: self, at: index)
        
        return cell
    }
    
}
