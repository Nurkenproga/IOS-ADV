import Foundation

struct CurrentWeatherData {
        let temperature: Double
        let weatherCode: Int
        let windSpeed: Double
        let humidity: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case weather
    }

    enum WeatherKeys: String, CodingKey {
        case description
        case icon
    }

}
