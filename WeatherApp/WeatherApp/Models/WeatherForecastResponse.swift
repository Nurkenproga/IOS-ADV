
import Foundation

struct WeatherForecastResponse: Decodable {
    let location: Location
    let timelines: Timelines

    struct Location: Decodable {
        let name: String?
    }

    struct Timelines: Decodable {
        let daily: [DailyForecast]
    }

    struct DailyForecast: Decodable {
        let time: String
        let values: ForecastValues
    }

    struct ForecastValues: Decodable {
        let temperatureMax: Double
        let temperatureMin: Double
        let weatherCodeMax: Int
    }
}
