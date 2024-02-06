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
                NavigationLink(destination: BusTimetableView(busLine: busLine, busStop: stop)) {
                    Text(stop.name)
                }
            }
            .navigationBarTitle("Stops for Bus: \(busLine.number)")
        }
    }
}



