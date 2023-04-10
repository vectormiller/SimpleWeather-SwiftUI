//
//  LocationView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/3/23.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct LocationView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var searchText = ""
    
    @Binding var weather: ResponseBody //
    //@StateObject var weatherManager: WeatherManager //
    var weatherManager = WeatherManager()
    
    var body: some View {
        VStack {
            VStack {
                TextField("Add a location...", text: $searchText, onCommit: {
                    locationManager.search(searchText: searchText)
                    //weather.name = "View update test" // Тест на апдейт в ForecastView
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                List(locationManager.locations, id: \.1.latitude) { location in
                    Button(action: {
                        let coordinate = CLLocationCoordinate2D(latitude: Double(location.1.latitude), longitude: Double(location.1.longitude))
//                        locationManager.search(searchText: location.0)
                        locationManager.locationInfo = location.0
                        locationManager.location = coordinate
                    }) {
                        VStack(alignment: .leading) {
                            Text("\(location.0)")
                            Text("\(location.1.latitude), \(location.1.longitude)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .onChange(of: locationManager.locationInfo) { _ in
            Task {
                do {
                    weather = try await weatherManager.getCurrentWeather(latitude: locationManager.location!.latitude, longitude: locationManager.location!.longitude)
                } catch {
                    print("Error while getting weather: \(error)")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        //        LocationView(weather: .constant(previewWeather), weatherManager: WeatherManager())
        LocationView(weather: .constant(previewWeather))
            .environmentObject(LocationManager())
    }
}
