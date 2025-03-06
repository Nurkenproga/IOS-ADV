//
//  HeroModelView.swift
//  HeroAssignment3
//
//  Created by Nurken on 05.03.2025.
//

import UIKit
import SwiftUI

struct Hero: Decodable {
    var id: Int?
    var name: String?
    var appearance: Appearance?
    var biography: Biography?
    var images: Images
    
    var imageUrl: URL? {
        URL(string: images.md)
    }
}

struct Appearance: Decodable {
    var gender: String?
    var race: String?
}

struct Biography: Decodable {
    var fullName: String?
    var placeOfBirth: String?
    var publisher: String?
}

struct Images: Decodable {
    var md: String
}


final class HeroViewModel: ObservableObject {
    @Published var selectedHero: Hero?

    
    func fetchHero() async {
        guard
            let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")
        else {
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()

            await MainActor.run {
                selectedHero = randomHero
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
}
