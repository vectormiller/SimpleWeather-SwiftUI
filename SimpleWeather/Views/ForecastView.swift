//
//  ForecastView.swift
//  SimpleWeather
//
//  Created by vectormiller on 3/30/23.
//

import SwiftUI


struct ForecastView: View {
    @State private var defaultTab = "Forecast"
    @State private var isPresentLocations = false
    @State private var isPresentSettings = false
    
    @EnvironmentObject var locationManager: LocationManager
    
    @State var weather: ResponseBody
    @StateObject var weatherManager = WeatherManager()
    
    @ObservedObject var userSettings: UserSettings

    
    var body: some View {
        NavigationView { // TabView doesnt work best
            VStack(spacing: 0) {
                
                Button(action: {
                    isPresentLocations.toggle()
                }) {
                    VStack(spacing: 10) {
                        HStack(alignment: .center) {
                            Text(locationManager.locationInfo == "" ? "Омск, Омская область" : locationManager.locationInfo)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 22))
                                .bold()
                        }
                        .font(.system(size: 20))
                        Rectangle()
                            .frame(height: 2)
                    }
                    .padding(.horizontal, 18) // Header padding
                    .foregroundColor(.green)
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        RightNowView(weather: $weather)
                        
                        NavigationLink(destination: InDevelopmentView()) {
                            Text("Switch to other forecast sources!\nUpgrade now →")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .font(.system(size: 19, weight: .bold))
                                .padding()
                                .background(Color.indigo)
                                .cornerRadius(16)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        TonightView(weather: $weather)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 15)
                    
                    Spacer().frame(height: 100) // Чтобы не перекрывал Overlay
                }
                //.padding(.horizontal, 20)
                .overlay(
                    VStack {
                        Spacer()
                        VStack {
                            
                            HStack(alignment: .bottom) {
                                Button(action: {
                                    isPresentLocations.toggle()
                                }) {
                                    VStack(alignment: .center) {
                                        Image(systemName: "mappin.and.ellipse")
                                            .font(.system(size: 22))
                                        Text("Locations")
                                    }
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "chart.bar.xaxis")
                                        .font(.system(size: 22))
                                    Text("Forecast")
                                }
                                .foregroundColor(.green)
                                Spacer()
                                Button(action: {
                                    isPresentSettings.toggle()
                                }) {
                                    VStack {
                                        Image(systemName: "gearshape.fill")
                                            .font(.system(size: 22))
                                        Text("Settings")
                                    }
                                }
                            }
                            .frame(width: nil, height: 70)
                            .padding(.horizontal, 35)
                            .bold()
                        }
                        .background(.thinMaterial)
                        .foregroundColor(.gray)
                    }
                )
                
            }
        }
        .sheet(isPresented: $isPresentSettings) {
            SettingsView(userSettings: userSettings)
                .preferredColorScheme(userSettings.darkModeEnabled ? .dark : .light)
        }
        .sheet(isPresented: $isPresentLocations) {
            LocationView(weather: $weather)
        }
    }
    
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(weather: previewWeather, userSettings: UserSettings())
            .environmentObject(LocationManager())
    }
}
