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
            
            userQueue.asyncAfter(deadline: .now() + 2) {
                self.checkUsersPacks()
            }
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
    
    private func checkUsersPacks() {
        let group = DispatchGroup()
        var needUpdatePacks = false
        
        for user in users {
            if let tune = user.tune {
                group.enter()
                
                PackManager.shared.loadPrompts(for: tune.id) { [weak self] result in
                    switch result {
                    case .success(let prompts):
                        guard let self = self else { return }
                        
                        for pack in user.packs {
                            if pack.isGenerating {
                                if let prompt = prompts.first(where: { pack.prompt?.id == $0.id }), prompt.images?.isEmpty == false {
                                    let newPack = pack.copy()
                                    newPack.prompt = prompt
                                    newPack.isGenerating = false
                                    needUpdatePacks = true
                                    
                                    let index = user.packs.firstIndex(of: pack)!
                                    user.packs.remove(at: index)
                                    self.addPack(newPack, for: user)
                                }
                            }
                        }
                        
                        group.leave()
                        
                    case .failure(let error):
                        group.leave()
                        logError(error)
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            if needUpdatePacks {
                NotificationCenter.default.post(name: .packsDidUpdated, object: nil)
            }
        }
    }
    
}
