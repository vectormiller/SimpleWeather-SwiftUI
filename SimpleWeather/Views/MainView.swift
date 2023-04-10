//
//  MainView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/5/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var locationManager = LocationManager()
    
    @StateObject var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    @ObservedObject var userSettings: UserSettings
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                //Text("Получили локацию: \(locationManager.locationInfo)")
                if let weather = weather {
                    ForecastView(weather: weather, userSettings: userSettings)
                        .environmentObject(locationManager)
                } else {
                    //Text("Парсим погоду для локации")
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    //EmptyView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch { print("Error while getting weather: \(error)") }
                        }
                }
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(userSettings: UserSettings())
    }
}
