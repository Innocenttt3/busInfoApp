//
//  LocationUtilities.swift
//  busInfo
//
//  Created by Kamil Golawski on 04/02/2024.
//

import Foundation
import CoreLocation

class LocationUtilities: NSObject, CLLocationManagerDelegate {
    static let shared = LocationUtilities()
    private let locationManager = CLLocationManager()
    private var completionHandler: ((CLLocation?, Error?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func getCurrentLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        completionHandler = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func requestLocation(){
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            completionHandler?(location, nil)
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(nil, error)
    }
    func calculateDistance(from location1: CLLocation, to location2: CLLocation) -> CLLocationDistance {
            return location1.distance(from: location2)
    }
    
}
