import UIKit

struct SettingsModel {
    
    enum SettingType {
        case restore
        case feedback
        case privacy
        case terms
        case manage
        
        var image: UIImage {
            switch self {
            case .restore: return R.image.settingsRestore()!
            case .feedback: return R.image.settingsFeedback()!
            case .privacy: return R.image.settingsPrivacy()!
            case .terms: return R.image.settingsPrivacy()!
            case .manage: return R.image.settingsManageData()!
            }
        }
        
        var label: String {
            switch self {
            case .restore: return R.string.localizable.settingsRestore()
            case .feedback: return R.string.localizable.settingsFeedback()
            case .privacy: return R.string.localizable.settingsPrivacy()
            case .terms: return R.string.localizable.settingsTerms()
            case .manage: return R.string.localizable.settingsManageData()
            }
        }
    }
    
    let type: SettingType
    let title: String
    let image: UIImage
    
    init(type: SettingType) {
        self.type = type
        title = type.label
        image = type.image
    }
}
