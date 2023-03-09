import Foundation

class DeeplinkNavigator {
    static let shared = DeeplinkNavigator()
    
    func proceedToDeeplink(_ type: DeeplinkType) {
        switch type {
        case .prompt(let prompt):
            handlePrompt(prompt)
        }
    }
    
    // MARK: - Private methods
    
    private func handlePrompt(_ prompt: Prompt) {
        if let user = UserManager.shared.users.first(where: { $0.tune?.id == prompt.tuneId }) {
            if let pack = user.packs.first(where: { $0.prompts == prompt.text }) {
//                pack.isGenerating = false
//                pack.prompt = prompt
//                UserManager.shared.saveUsers()
                
                let newPack = pack
                newPack.isGenerating = false
                newPack.prompt = prompt
                let index = user.packs.firstIndex(of: pack)!
                user.packs.remove(at: index)
                UserManager.shared.addPack(newPack)
//                user.packs.append(newPack)
//                UserManager.shared.saveUsers()
                
                NotificationCenter.default.post(name: .packsDidUpdated, object: nil)
            } else {
                print("❤️ error handel prompt - user not found")
            }
        } else {
            print("❤️ error handel prompt - user not found")
        }
    }
}
