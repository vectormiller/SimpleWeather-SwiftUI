//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/4/23.
//

import Foundation
import CoreLocation


class WeatherManager: ObservableObject {
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        print("Getting weather for location (\(latitude), \(longitude))")
        guard let url = URL(
            string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=1be404c653723e85751402d39aa9ac89&units=metric"
        ) else { fatalError("No API URL was given!") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while sending API request") }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let decodedData = try decoder.decode(ResponseBody.self, from: data)
//        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// Data model for JSON Decoder
struct ResponseBody: Decodable {
    var list: [ListResponse]
    var city: CityResponse
    
    struct CityResponse: Decodable {
        var id: Double                 // 1496153
        var name: String               // "Omsk"
        var coord: CoordinatesResponse // {}
        var country: String            // "RU"
        var population: Double         // 1129281
        var timezone: Double           // 21600       -- timestamp
        var sunrise: Date              // 1680827066  -- timestamp
        var sunset: Date               // 1680875567  -- timestamp
    }

    struct CoordinatesResponse: Decodable {
        var lat: Double // latitude
        var lon: Double // longitude
    }
    
    struct ListResponse: Decodable {
        var dt: Date                 // 1680890400  -- timestamp
        var main: MainResponse       // {}
        var weather: [WeatherResponse] // {}
        var clouds: CloudsResponse   // {}
        var wind: WindResponse       // {}
        var visibility: Double       // 10000
        var pop: Double              // 0.33
        var dt_txt: String           // "2023-04-07 18:00:00"
    }
    
    struct MainResponse: Decodable {
        var temp: Double       // -5.46
        var feels_like: Double // -11.98
        var temp_min: Double   // -6.33
        var temp_max: Double   // -5.46
        var pressure: Double   // 1027
        var sea_level: Double  // 1027
        var grnd_level: Double // 1018
        var humidity: Double   // 37
        var temp_kf: Double    // 0.87
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
        
        var weatherIcon: String {
            switch icon {
                case "01d":
                    return "clear-day"
                case "01n":
                    return "clear-night"
                case "02d":
                    return "partly-cloudy-day"
                case "02n":
                    return "partly-cloudy-night"
                case "03d", "04d":
                    return "cloudy"
                case "03n", "04n":
                    return "overcast"
                case "09d", "09n":
                    return "heavy-showers"
                case "10d", "10n":
                    return "showers"
                case "11d", "11n":
                    return "thunderstorm-showers"
                case "13d", "13n":
                    return "heavy-snow"
                case "50d", "50n":
                    return "fog"
                default:
                    return "partly-cloudy-day"
            }
        }
    }
    
    struct CloudsResponse: Decodable {
        var all: Double
    }

    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
        var gust: Double
    }
    
}



