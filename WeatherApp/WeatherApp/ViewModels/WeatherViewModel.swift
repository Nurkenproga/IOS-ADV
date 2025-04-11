import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var forecast: WeatherForecastResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = WeatherService()

    func loadForecast(latitude: Double = 42.3478, longitude: Double = -71.0466) {
        Task {
            isLoading = true
            errorMessage = nil

            do {
                let result = try await service.fetchForecast(latitude: latitude, longitude: longitude)
                forecast = result
            } catch {
                errorMessage = "Failed to load forecast: \(error.localizedDescription)"
            }

            isLoading = false
        }
    }
}
