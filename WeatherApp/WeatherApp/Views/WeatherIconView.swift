import SwiftUI

struct WeatherIconView: View {
    let code: Int

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .frame(width: 50, height: 50)
            .padding()

    }

    private var iconName: String {
        switch code {
        case 1000: return "sun.max.fill"
        case 1100...1199: return "cloud.sun.fill"
        case 1200...1299: return "cloud.rain.fill"
        case 1300...1399: return "cloud.snow.fill"
        case 1400...1499: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }
}
