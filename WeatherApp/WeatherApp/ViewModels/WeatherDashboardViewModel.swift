import Foundation

@MainActor
final class WeatherDashboardViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherData?
    @Published var forecast: WeatherForecastResponse?
    @Published var airQuality: AirQualityData?
    @Published var alerts: [WeatherAlert]?
    @Published var radarMapImageURL: URL?

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = WeatherService()

    func loadAllWeatherData(latitude: Double = 42.3478, longitude: Double = -71.0466) {
        Task {
            isLoading = true
            errorMessage = nil

            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    do {
                        service.fetchCurrentWeather(latitude: latitude, longitude: longitude)                    } catch {
                        self.errorMessage = "Ошибка загрузки текущей погоды: \(error.localizedDescription)"
                    }
                }

                group.addTask {
                    do {
                        self.forecast = try await service.fetchForecast(latitude: latitude, longitude: longitude)
                    } catch {
                        self.errorMessage = "Ошибка загрузки прогноза: \(error.localizedDescription)"
                    }
                }

                group.addTask {
                    do {
                        self.airQuality = try await service.fetchAirQuality(latitude: latitude, longitude: longitude)
                    } catch {
                        self.errorMessage = "Ошибка загрузки качества воздуха: \(error.localizedDescription)"
                    }
                }

//                group.addTask {
//                    do {
//                        self.alerts = try await service.fetchAlerts(lat: latitude, lon: longitude)
//                    } catch {
//                        self.errorMessage = "Ошибка загрузки предупреждений: \(error.localizedDescription)"
//                    }
//                }
//
//                group.addTask {
//                    do {
//                        self.radarMapImageURL = try await service.fetchRadarMap(lat: latitude, lon: longitude)
//                    } catch {
//                        self.errorMessage = "Ошибка загрузки карты осадков: \(error.localizedDescription)"
//                    }
//               }
            }

            isLoading = false
        }
    }
}
