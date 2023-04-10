//
//  SettingsView.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/3/23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var userSettings: UserSettings
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Display Options")) {
                    NavigationLink(destination: EmptyView()) {
                        HStack(alignment: .center) {
                            Label("Units", systemImage: "globe")
                            Spacer()
                            Text("Metric")
                        }
                    }
                    .disabled(true)
                    .opacity(0.6)
                    Toggle(isOn: $userSettings.darkModeEnabled) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }
                Section(header: Text("Exclusive Extras")) {
                    NavigationLink(destination: InDevelopmentView()) {
                        Label("Upgrade Now", systemImage: "heart.fill")
                    }
                    Label("Forecast Data", systemImage: "chart.bar.xaxis")
                        .disabled(true)
                        .opacity(0.6)
                    Label("App Icon", systemImage: "gearshape.fill")
                        .disabled(true)
                        .opacity(0.6)
                    Label("Theme Color", systemImage: "paintpalette.fill")
                        .disabled(true)
                        .opacity(0.6)
                    Label("Apple Watch", systemImage: "applewatch")
                        .disabled(true)
                        .opacity(0.6)
                }
                Section(header: Text("Have a question or need help?")) {
                    NavigationLink(destination: FAQView()) {
                        Label("FAQs", systemImage: "questionmark.circle.fill")
                    }
                    NavigationLink(destination: EmailView()) {
                        Label("Email Support", systemImage: "mail.fill")
                    }
                    NavigationLink(destination: RateAppView()) {
                        Label("Rate This App", systemImage: "star.fill")
                    }
                }
                Text("Thanks for using Simple Weather! ♡")
                    .foregroundColor(.gray)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(userSettings: UserSettings())
    }
}
