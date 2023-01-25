import UIKit

class ProfileView: RootView {

    let addContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 48/2
        view.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let addImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.profileCellAdd()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.mainAddProfile()
        label.font = .interFont(ofSize: 14, weight: .semiBold)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    override func setup() {
        layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 80/2
        
        addSubview(addContainer)
        addSubview(titleLabel)
        
        addContainer.addSubview(addImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addContainer.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(16.0)
        }
        
        addImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12.0)
            make.size.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(addContainer.snp.right).offset(8.0)
            make.right.equalToSuperview().offset(-16.0 * 2)
            make.centerY.equalToSuperview()
        }
    }
}
