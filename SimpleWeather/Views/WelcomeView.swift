//
//  WelcomeView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/4/23.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    
    
    var body: some View {
        VStack {
            Image("WeatherAppLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 250, maxHeight: 250)
            VStack(spacing: 20) {
                Text("Welcome to Simple Weather")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
    
                Text("To get a weather forecast customized just for you, please grant us permission to access your location.")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Text("We want to assure you that your location data will not be stored anywhere and this process is completely safe and secure.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.horizontal)
            }
            .padding()
            
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(.indigo.opacity(0.4))
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
