import UIKit

class PackDescriptionHeaderView: UICollectionReusableView {
     
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TEXT"
        label.textAlignment = .center
        
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
