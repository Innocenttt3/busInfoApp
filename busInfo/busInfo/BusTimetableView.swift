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
    @State private var shareText: String = ""
    @State private var selectedTimeIndex: Int?

    var body: some View {
        ZStack {
            List {
                ForEach(busStop.timetable.indices, id: \.self) { index in
                    if currentTimeAsInt() < self.busStop.timetable[index] {
                        VStack(alignment: .leading) {
                            Button(action: {
                                let time = formatTime(self.busStop.timetable[index])
                                self.shareText = "I'm catching the bus number \(self.busLine.number) at \(time) from \(self.busStop.name)."
                                self.selectedTimeIndex = index
                            }) {
                                Text(formatTime(self.busStop.timetable[index]))

                                    .foregroundColor(self.selectedTimeIndex == index ? .blue : .primary)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("\(busLine.number) - \(busStop.name) ⏰", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            let window = windowScene.windows.first(where: { $0.isKeyWindow })
                            let activityController = UIActivityViewController(activityItems: [self.shareText], applicationActivities: nil)
                            window?.rootViewController?.present(activityController, animated: true, completion: nil)
                        }
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            
            VStack {
                Spacer()
                if let userLocation = userLocation, let busStopLocation = busStop.location {
                    let distanceInMeters = userLocation.distance(from: busStopLocation)
                    let distanceInKilometers = Measurement(value: distanceInMeters, unit: UnitLength.meters).converted(to: .kilometers).value
                    let roundedDistance = String(format: "%.2f", distanceInKilometers)
                    let timeDistance = Int(distanceInMeters/70)
                    Text("Distance to bus stop: \(roundedDistance) kilometers")
                    Text("It will take around \(timeDistance) minutes to get there")
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
            if let firstTime = busStop.timetable.first {
                self.shareText = "I'm catching the bus number \(busLine.number) at \(formatTime(firstTime)) from \(busStop.name)."
            }
        }
    }
}






