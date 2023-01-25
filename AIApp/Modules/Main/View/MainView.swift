import UIKit

class MainView: RootView {

    let logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = R.image.mainLogo()
        
        return view
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.mainSettings(), for: .normal)
        
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.contentOffset = .zero
        view.contentInsetAdjustmentBehavior = .never
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(logoImageView)
        addSubview(settingsButton)
        addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.height.equalTo(24.0)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.0)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.size.equalTo(24.0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(16.0)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
