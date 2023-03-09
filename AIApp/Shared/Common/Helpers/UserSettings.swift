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
            defaults.synchronize()
            return defaults.data(forKey: #function)
        }
        set {
            DispatchQueue.main.async {
                defaults.synchronize()
                defaults.set(newValue, forKey: #function)
                defaults.synchronize()
            }
        }
    }
}
