//
//  Extensions.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/4/23.
//

import Foundation
import CoreLocation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self) // Округляем Double
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
