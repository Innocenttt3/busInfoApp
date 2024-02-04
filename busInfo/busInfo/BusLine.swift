//
//  User.swift
//  busInfo
//
//  Created by Kamil Golawski on 01/02/2024.
//

import Foundation

class BusLine: ObservableObject, Identifiable {
    var id = UUID()
    var number: Int
    var stops: [BusStop]

    init(number: Int, stops: [BusStop]) {
        self.number = number
        self.stops = stops
    }
}


