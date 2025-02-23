import Foundation

class ProfileManager {
    
    static let shared = ProfileManager()
    
    private var currentProfile: UserProfile?
    
    var onProfileUpdated: ((UserProfile) -> Void)?
    
    private init() {}
    
    func loadProfile(completion: @escaping (UserProfile) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            let profile = UserProfile(username: "Нуркенчик", bio: "Программист iOS")
            self?.currentProfile = profile
            
            DispatchQueue.main.async {
                completion(profile)
            }
        }
    }
    
    func updateProfile(username: String, bio: String) {
        currentProfile = UserProfile(username: username, bio: bio)
        
        
        onProfileUpdated?(currentProfile!)
    }
}
