import Foundation

class UserManager {
    
    enum UserGender: String {
        case man
        case woman
    }
    
    static let shared = UserManager()
    
    var selectedUser: User {
        return users.first(where: { $0.isSelected })!
    }
    
    private(set) var users: [User] = []
    private let userQueue: DispatchQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).userQeue")
    
    init() {
        do {
            guard let data = UserSettings.users else { return }
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print("❤️ Faild decode users in init(), error:", error)
        }
    }
    
    // MARK: - Public methods
    
    @discardableResult
    func createUser(name: String = "", gender: String = "", photos: [Data]) -> User {
        let newUser = User(id: generateUniqueID(), name: name, gender: gender, photos: photos)
        users.insert(newUser, at: 0)
        selectUser(user: newUser)
        
        saveUsers()
        
        return newUser
    }
    
    func selectUser(user: User) {
        users.forEach { $0.isSelected = $0 == user }
        saveUsers()
    }
    
    func deleteAllUsers() {
        users.removeAll()        
        saveUsers()
    }
    
    func setName(_ name: String, for user: User? = nil) {
        let user = user ?? selectedUser
        guard let user = users.first(where: { $0 == user }) else { return }
        
        user.name = name
        saveUsers()
    }
    
    func setGender(_ gender: UserGender, for user: User? = nil) {
        let user = user ?? selectedUser
        guard let user = users.first(where: { $0 == user }) else { return }
        
        user.gender = gender.rawValue
        saveUsers()
    }
    
    func addPack(_ pack: Pack, for user: User? = nil) {
        let user = user ?? selectedUser
        guard let user = users.first(where: { $0 == user }) else { return }
        
        user.packs.append(pack)
        saveUsers()
    }
    
    func setTune(_ tune: Tune, for user: User? = nil) {
        let user = user ?? selectedUser
        guard let user = users.first(where: { $0 == user }) else { return }
        
        user.tune = tune
        saveUsers()
    }
    
    func saveUsers() {
        userQueue.async {
            do {
                let data = try JSONEncoder().encode(self.users)
                UserSettings.users = data
            } catch {
                print("❤️ Faild encode users in saveUsers(), error:",  error)
            }
        }
    }
     
    // MARK: - Private methods
    
    private func generateUniqueID() -> String {
        var id = UUID().uuidString
        while users.contains(where: { $0.id == id }) {
            id = UUID().uuidString
        }
        
        return id
    }
}
