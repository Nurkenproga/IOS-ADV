import Foundation

struct HeroEntity: Decodable {
    let id: Int
    let name: String
    let appearance: Appearance
    let powerstats: PowerStats
    let biography: Biography
    let images: HeroImage

    var heroImageUrl: URL? {
        URL(string: images.sm)
    }

    struct Appearance: Decodable {
        let race: String?
    }

    struct PowerStats: Decodable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }

    struct Biography: Decodable {
        let fullName: String
        let placeOfBirth: String?
        let publisher: String?
    }

    struct HeroImage: Decodable {
        let sm: String
        let md: String
    }
}
