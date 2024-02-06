//
//  BusTimetableView.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import SwiftUI
import CoreLocation

struct BusTimetableView: View {
    var busLine: BusLine
    var busStop: BusStop

    @State private var userLocation: CLLocation?

    var body: some View {
        ZStack {
            List {
                ForEach(busStop.timetable.indices, id: \.self) { index in
                    if currentTimeAsInt() < self.busStop.timetable[index] {
                        VStack(alignment: .leading) {
                            Text(formatTime(self.busStop.timetable[index]))
                        }
                    }
                }
            }
            .navigationBarTitle("\(busLine.number) - \(busStop.name)", displayMode: .inline)
            
            VStack {
                Spacer()
                if let userLocation = userLocation, let busStopLocation = busStop.location {
                    let distance = userLocation.distance(from: busStopLocation)
                    let roundedDistance = Int(distance)
                    Text("Distance to bus stop: \(roundedDistance) meters")
                    
                } else {
                    Text("Loading...")
                }
            }
        }
        .onAppear {
            LocationUtilities.shared.getCurrentLocation { location, error in
                if let error = error {
                    print("Failed to get user's location: \(error.localizedDescription)")
                } else if let location = location {
                    self.userLocation = location
                }
            }
        }
    }
}






