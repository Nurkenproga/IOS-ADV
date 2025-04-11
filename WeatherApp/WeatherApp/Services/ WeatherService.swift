import Foundation


final class WeatherService {
    private let apiKey = "6RtK0KPQnD1fW0mokNn1ZQGpOOpfdSus"
    private let forecastBaseURL = "https://api.tomorrow.io/v4/weather/forecast"
    private let realtimeBaseURL = "https://api.tomorrow.io/v4/weather/realtime"

    func fetchForecast(latitude: Double, longitude: Double) async throws -> WeatherForecastResponse {
        guard var urlComponents = URLComponents(string: forecastBaseURL) else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "location", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(WeatherForecastResponse.self, from: data)
    }

    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> CurrentWeatherData {
        guard var urlComponents = URLComponents(string: "https://api.tomorrow.io/v4/weather/realtime") else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "location", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
        let values = decoded.data.values

        return CurrentWeatherData(
            temperature: values.temperature,
            weatherCode: values.weatherCode,
            windSpeed: values.windSpeed,
            humidity: values.humidity
        )
    }
    func fetchAirQuality(latitude: Double, longitude: Double) async throws -> AirQualityData {
        guard var urlComponents = URLComponents(string: "https://api.tomorrow.io/v4/weather/air-quality") else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "location", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(TomorrowAirQualityResponse.self, from: data)
        let values = decoded.data.values

        return AirQualityData(epaIndex: values.epaIndex, description: "EPA Index: \(values.epaIndex)")
    }
}
