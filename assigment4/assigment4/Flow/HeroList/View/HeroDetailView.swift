import SwiftUI

struct HeroDetailView: View {
    @StateObject var viewModel: HeroDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let hero = viewModel.hero {
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        AsyncImage(url: hero.heroImageUrl) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        
                        Text(hero.name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Power Stats")
                            .font(.headline)
                        
                        Text("Strength: \(hero.powerstats.strength)")
                        Text("Speed: \(hero.powerstats.speed)")
                        Text("Intelligence: \(hero.powerstats.intelligence)")
                        
                        Text("Biography")
                            .font(.headline)
                        Text(hero.biography.fullName)
                        if let place = hero.biography.placeOfBirth {
                            Text("Born in: \(place)")
                        }
                    }
                    .padding()
                }
            } else {
                Text(viewModel.errorMessage ?? "Error loading hero")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.fetchHero()
        }
    }
}
