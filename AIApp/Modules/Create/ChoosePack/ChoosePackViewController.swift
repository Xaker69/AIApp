import UIKit

class ChoosePackViewController: UIViewController {

    var mainView: ChoosePackView {
        return view as! ChoosePackView
    }
        
    var dataSource = CloudManager.shared.packs
    
    override func loadView() {
        view = ChoosePackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        mainView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
                
        NotificationCenter.default.addObserver(self, selector: #selector(packsDidLoaded), name: .packsDidLoaded, object: nil)
    }
        
    // MARK: - Private actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func continueButtonTapped() {
        navigationController?.setViewControllers([MainViewController()], animated: true)
    }
    
    @objc private func packsDidLoaded() {
        dataSource = CloudManager.shared.packs
        mainView.collectionView.reloadData()
    }
}

extension ChoosePackViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoosePackCell.description(), for: indexPath) as! ChoosePackCell
        
        cell.imageView.kf.setImage(with: dataSource[indexPath.item].previewImage)
        cell.titleLabel.text = dataSource[indexPath.item].name
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PackDescriptionViewController(pack: dataSource[indexPath.item])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 24 * 2, height: collectionView.bounds.height)
    }
}
