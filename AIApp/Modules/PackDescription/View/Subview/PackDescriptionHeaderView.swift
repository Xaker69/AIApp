import UIKit

class PackDescriptionHeaderView: UICollectionReusableView {
     
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.packDescriptionHeaderTitle()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(48.0)
        }
    }
}
