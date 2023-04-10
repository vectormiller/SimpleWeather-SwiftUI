//
//  LocationManager.swift
//  SimpleWeather
//
//  Created by vectormiller on 4/4/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var locationInfo: String = ""
    @Published var locations: [(String, CLLocationCoordinate2D)] = []
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
        
    }
    
    func search(searchText: String) {
        print("Поиск координат и места для: \(searchText)")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { placemarks, error in
            guard let placemark = placemarks?.first,
                  let location = placemark.location?.coordinate else {
                return
            }
            self.locations.append(("\(placemark.locality ?? "Unknown"), \(placemark.administrativeArea ?? "Unknown")", location))
            self.locationInfo = "\(placemark.locality ?? "Unknown"), \(placemark.administrativeArea ?? "Unknown")"
            self.location = location
            print("Нашли локацию: \(placemark.locality ?? "Unknown"), \(placemark.administrativeArea ?? "Unknown")")
            print("Координаты: \(location.latitude) и \(location.longitude)")
        }
    }
    
    
    
    
    func decodeCoord(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                return
            }
            if let locality = placemark.locality,
               let administrativeArea = placemark.administrativeArea {
                self.locationInfo = "\(locality), \(administrativeArea)"
            } else if let name = placemark.name {
                self.locationInfo = name
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        if let tempLocation = self.location {
            decodeCoord(latitude: tempLocation.latitude, longitude: tempLocation.longitude)
        }
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location coordinates", error)
        isLoading = false
    }
    
}
