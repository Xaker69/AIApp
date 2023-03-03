import UIKit

class PagingFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
 
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        scrollDirection = .horizontal
        minimumLineSpacing = 12
    }

    override func prepare() {            
        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        return rectAttributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        
        var offset = CGFloat.greatestFiniteMagnitude
        
        let horizontalOffset = proposedContentOffset.x + collectionView.frame.width / 2
        
        let layoutAttributes = super.layoutAttributesForElements(in: proposedRect)!
        
        for attribute in layoutAttributes {
            let itemOffset = attribute.center.x
            if abs(itemOffset - horizontalOffset) < abs(offset) {
                print(Int(itemOffset), Int(horizontalOffset), Float(offset))
                offset = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offset, y: proposedContentOffset.y)
    }


    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
