import UIKit

class SettingsCell: UITableViewCell {

    let iconImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let cellImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.settingsCell()
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 1, alpha: 0.1)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cellImageView)
        contentView.addSubview(separatorView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(20.0)
            make.size.equalTo(24.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(16.0)
            make.right.equalTo(cellImageView.snp.left).offset(-16.0)
        }
        
        cellImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.0)
            make.size.equalTo(24.0)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
            make.left.right.equalToSuperview().inset(20.0)
        }
    }

}
