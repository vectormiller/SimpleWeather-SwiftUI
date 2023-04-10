//
//  BarModel.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/9/23.
//

import Foundation
import SwiftUI

struct Bar: Identifiable {
    let id = UUID()
    var name: String
    var hour: String
    var value: Double
    var color: Color
    var icon: String
    
    static let icons = ["clear-day", "clear-night", "cloudy", "fog", "heavy-showers", "heavy-sleet", "heavy-snow", "overcast", "partly-cloudy-day", "partly-cloudy-night", "showers", "sleet", "snow", "thunderstorm-showers", "thunderstorm-snow", "windy"]
    
    static var sampleBars: [Bar] {
        var tempBars = [Bar]()
        let color: Color = .green // default value
        let hours = ["18:00", "20:00", "22:00", "0:00", "2:00", "4:00", "6:00"]
        
        
        for i in 1...hours.count {
            let rand = Double.random(in: 0...50)
            
            let bar = Bar(name: "\(i)", hour: hours[i-1], value: rand, color: color, icon: Bar.icons.randomElement()!)
            tempBars.append(bar)
        }
        return tempBars
    }
}
