import UIKit
import Atributika

class GeneratedPhotoView: RootView {
    
    let headerView: UIView = UIView()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.close(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let counterContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex6: 0x161616)
        view.layer.cornerRadius = 28/2
        
        return view
    }()
    
    let counterLabel: AttributedLabel = {
        let label = AttributedLabel()
        
        let current = Style("current")
            .font(.interFont(ofSize: 13, weight: .semiBold))
            .foregroundColor(.white)
        
        let count = Style("count")
            .font(.interFont(ofSize: 13, weight: .semiBold))
            .foregroundColor(.init(white: 1, alpha: 0.2))
        
        label.attributedText = R.string.localizable.generatedCounter("1", "100").style(tags: [current, count])
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.generatedSave(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        
        return button
    }()
    
    let actionsView: ActionsView = {
        let view = ActionsView()
        
        return view
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(headerView)
        addSubview(collectionView)
        addSubview(saveButton)
        addSubview(actionsView)
        
        headerView.addSubview(closeButton)
        headerView.addSubview(counterContainer)
        
        counterContainer.addSubview(counterLabel)
        
        setupConstraints()
    }
    
    func setCount(index: Int, count: Int) {
        let current = Style("current")
            .font(.interFont(ofSize: 13, weight: .semiBold))
            .foregroundColor(.white)
        
        let countStyle = Style("count")
            .font(.interFont(ofSize: 13, weight: .semiBold))
            .foregroundColor(.init(white: 1, alpha: 0.2))
        
        counterLabel.attributedText = R.string.localizable.generatedCounter("\(index)", "\(count)").style(tags: [current, countStyle])
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16.0)
            make.left.equalToSuperview().offset(20.0)
            make.size.equalTo(24.0)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(actionsView.snp.top).offset(-24.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
        }
        
        actionsView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.centerX.equalToSuperview()
        }
        
        counterContainer.snp.makeConstraints { make in
            make.height.equalTo(28.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20.0)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8.0)
            make.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.width * 400/335)
            make.left.right.equalToSuperview()
        }
    }
    
}
