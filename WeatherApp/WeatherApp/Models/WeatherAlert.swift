import Foundation

struct WeatherAlert: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let start: Date
    let end: Date
}
