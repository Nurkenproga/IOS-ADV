import Foundation
struct CurrentWeatherResponse: Decodable {
    let data: WeatherData

    struct WeatherData: Decodable {
        let time: String
        let values: WeatherValues
    }

    struct WeatherValues: Decodable {
        let temperature: Double
        let weatherCode: Int
        let windSpeed: Double
        let humidity: Double
    }
}
