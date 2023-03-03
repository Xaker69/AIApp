import UIKit
import Atributika
import PhotosUI

class UploadPhotosView: RootView {
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.back(), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.createAvatarStep("1")
        label.font = .interFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.uploadPhotosTitle()
        label.font = .satoshiFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.uploadPhotosSubtitle()
        label.font = .interFont(ofSize: 15, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.6)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.uploadPhotosButton(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interFont(ofSize: 15, weight: .bold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.isEnabled = false
        button.alpha = 0.1
        
        return button
    }()
    
    let boxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.image.boxUnselect(), for: .normal)
        button.setImage(R.image.boxSelect(), for: .selected)
        button.isSelected = false
        button.tintColor = .clear
        
        return button
    }()
    
    let privacyLabel: AttributedLabel = {
        let label = AttributedLabel()
        
        let all = Style("all")
            .foregroundColor(.white.withAlphaComponent(0.6))
            .font(.interFont(ofSize: 13, weight: .medium))
        
        let privacy = Style("privacy")
            .foregroundColor(.init(hex6: 0xA851FF))
            .foregroundColor(.init(hex6: 0xA851FF), .highlighted)
        
        let terms = Style("terms")
            .foregroundColor(.init(hex6: 0xA851FF))
            .foregroundColor(.init(hex6: 0xA851FF), .highlighted)
        
        label.attributedText = R.string.localizable.uploadPhotosPrivacy().style(tags: [all, privacy, terms])
        
        return label
    }()
    
    let privacyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var recommendsStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            SubAdvantageView(label: R.string.localizable.uploadPhotosGoodRecommendFirst(), imageTint: .init(hex6: 0x0AE25E)),
            SubAdvantageView(label: R.string.localizable.uploadPhotosGoodRecommendSecond(), imageTint: .init(hex6: 0x0AE25E)),
            SubAdvantageView(label: R.string.localizable.uploadPhotosGoodRecommendThird(), imageTint: .init(hex6: 0x0AE25E)),
            SubAdvantageView(label: R.string.localizable.uploadPhotosGoodRecommendFourth(), imageTint: .init(hex6: 0x0AE25E))
        ])
        view.distribution = .fillEqually
        view.alignment = .leading
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    lazy var notRecommendsStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            SubAdvantageView(type: .red, label: R.string.localizable.uploadPhotosBadRecommendFitst()),
            SubAdvantageView(type: .red, label: R.string.localizable.uploadPhotosBadRecommendSecond()),
        ])
        view.distribution = .fillEqually
        view.alignment = .leading
        view.axis = .vertical
        view.spacing = 8
        
        return view
    }()
    
    let configuration: PHPickerConfiguration = {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 20
        
        return configuration
    }()
    
    lazy var picker: PHPickerViewController = {
        let picker = PHPickerViewController(configuration: configuration)
        picker.overrideUserInterfaceStyle = .dark
        
        return picker
    }()
    
    override func setup() {
        backgroundColor = .init(hex6: 0x0F0F0F)
        
        addSubview(backButton)
        addSubview(stepLabel)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(uploadButton)
        addSubview(recommendsStack)
        addSubview(notRecommendsStack)
        addSubview(privacyView)
        
        privacyView.addSubview(boxButton)
        privacyView.addSubview(privacyLabel)
        
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
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(8.0)
        }
        
        recommendsStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40.0)
        }
        
        notRecommendsStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40.0)
            make.top.equalTo(recommendsStack.snp.bottom).offset(24.0)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(56.0)
        }
        
        privacyView.snp.makeConstraints { make in
            make.bottom.equalTo(uploadButton.snp.top).offset(-24.0)
            make.centerX.equalToSuperview()
        }
        
        boxButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.size.equalTo(24.0)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(boxButton.snp.centerY)
            make.left.equalTo(boxButton.snp.right).offset(8.0)
            make.right.equalToSuperview()
        }
    }
}
