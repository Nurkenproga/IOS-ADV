import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7), .white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    if viewModel.isLoading {
                        ProgressView("Loading weather...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else if let forecast = viewModel.forecast,
                              let daily = forecast.timelines.daily.first {
                        VStack(spacing: 10) {
                            WeatherIconView(code: daily.values.weatherCodeMax)
                            Text("Max: \(daily.values.temperatureMax, specifier: "%.1f")°C")
                            Text("Min: \(daily.values.temperatureMin, specifier: "%.1f")°C")
                        }
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                    }

                    Button(action: {
                        viewModel.loadForecast()
                    }) {
                        Text("Reload Forecast")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("WeatherApp")
        }
        .onAppear {
            viewModel.loadForecast()
        }
    }
}
