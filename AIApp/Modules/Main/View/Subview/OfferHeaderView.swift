import UIKit
import Atributika

class OfferHeaderView: UICollectionReusableView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.uploadingOfferTitle()
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let subtitleLabel: AttributedLabel = {
        let label = AttributedLabel()
        label.textColor = .init(white: 1, alpha: 0.6)
        label.font = .interFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        
        let style = Style("color")
            .foregroundColor(.init(hex6: 0xA851FF))
            .font(.interFont(ofSize: 15, weight: .bold))
        
        label.attributedText = R.string.localizable.uploadingOfferSubtitle().style(tags: [style])
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40.0)
            make.left.right.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
}
