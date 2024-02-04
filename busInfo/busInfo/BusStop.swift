//
//  BusStop.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import Foundation
import CoreLocation

class BusStop: ObservableObject, Identifiable {
    var id = UUID()
    var name: String?
    var timetable: [Int]?
    var location: CLLocation?

    init(name: String?, timetable: [Int]?, location: CLLocation?) {
        self.name = name
        self.timetable = timetable
        self.location = location
    }
}

