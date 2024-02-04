//
//  BusStopView.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import SwiftUI

struct BusStopsView: View {
    let busLine: BusLine
    
    var body: some View {
        NavigationView {
            List(busLine.stops) { stop in
                if let stopName = stop.name {
                    NavigationLink(destination: BusTimetableView(busLine: busLine, busStop: stop)) {
                        Text(stopName)
                    }
                }
            }

            .navigationBarTitle("Stops for Bus: \(busLine.number) 📍")
        }
    }
}



