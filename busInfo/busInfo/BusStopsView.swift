//
//  BusStopsView.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import SwiftUI

struct BusStopsView: View {
    let busLine: BusLine
    
    var body: some View {
        List(busLine.stops, id: \.self) { stop in
            Text(stop)
        }
        .navigationBarTitle("Stops for Bus \(busLine.number)")
    }
}




