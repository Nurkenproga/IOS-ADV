struct TomorrowAirQualityResponse: Decodable {
    let data: AQData

    struct AQData: Decodable {
        let time: String
        let values: AQValues
    }

    struct AQValues: Decodable {
        let epaIndex: Int
    }
}
