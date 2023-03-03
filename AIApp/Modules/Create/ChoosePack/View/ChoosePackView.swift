import UIKit

class ChoosePackView: RootView {

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.back(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.createAvatarStep("4")
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.choosePackTitle()
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.choosePackButton(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        
        return button
    }()
    
    let collectionView: UICollectionView =  {
        let layout = PagingFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ChoosePackCell.self, forCellWithReuseIdentifier: ChoosePackCell.description())
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(backButton)
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(continueButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(24.0)
        }
        
        stepLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(backButton.snp.bottom).offset(56.0)
        }
        
        continueButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32.0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-62.0)
        }
    }

}
