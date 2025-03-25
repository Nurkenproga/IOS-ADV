import SwiftUI

class HeroDetailViewModel: ObservableObject {
    @Published var hero: HeroEntity?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: HeroService
    private let heroId: Int
    
    init(heroId: Int, service: HeroService) {
        self.heroId = heroId
        self.service = service
    }
    
    func fetchHero() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let hero = try await service.fetchHeroById(id: heroId)
                DispatchQueue.main.async {
                    self.hero = hero
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
