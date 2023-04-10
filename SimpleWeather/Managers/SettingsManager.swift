//
//  SettingsManager.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/9/23.
//

import Foundation
import SwiftUI
import Combine


class UserSettings: ObservableObject {
    @Published var darkModeEnabled = false
}
