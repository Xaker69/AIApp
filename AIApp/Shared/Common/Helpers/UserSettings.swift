import Foundation

class UserSettings {
    
    static let defaults = UserDefaults.standard
    
    static var deviceToken: String? {
        get {
            defaults.string(forKey: #function)
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
    
    static var users: Data? {
        get {
            return defaults.data(forKey: #function)
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
}
