//
//  SimpleWeatherApp.swift
//  SimpleWeather
//
//  Created by vectormiller on 3/29/23.
//

import SwiftUI

@main
struct SimpleWeatherApp: App {
    @StateObject var userSettings: UserSettings = UserSettings()

    var body: some Scene {
        WindowGroup {
            MainView(userSettings: userSettings)
                .preferredColorScheme(userSettings.darkModeEnabled ? .dark : .light)
        }
    }
}
