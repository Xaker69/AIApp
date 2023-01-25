import UIKit

class ChoosePackViewController: UIViewController {

    var mainView: ChoosePackView {
        return view as! ChoosePackView
    }
    
    private var indexOfCellBeforeDragging = 0
    
    let dataSource = [1, 2, 3, 4, 5, 6]
    
    var collectionViewLayout: UICollectionViewFlowLayout {
        return mainView.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func loadView() {
        view = ChoosePackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.pageControl.numberOfPages = dataSource.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureCollectionViewLayoutItemSize()
    }
    
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func continueButtonTapped() {
        navigationController?.setViewControllers([MainViewController()], animated: true)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(dataSource.count - 1, index))
        return safeIndex
    }
    
    private func configureCollectionViewLayoutItemSize() {
        collectionViewLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - 20 - 20, height: collectionViewLayout.collectionView!.frame.size.height)
    }

}

extension ChoosePackViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoosePackCell.description(), for: indexPath) as! ChoosePackCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PackDescriptionViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < dataSource.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            
            mainView.pageControl.currentPage = snapToIndex
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            mainView.pageControl.currentPage = indexOfMajorCell
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
