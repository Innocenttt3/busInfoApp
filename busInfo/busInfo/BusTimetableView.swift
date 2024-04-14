import SwiftUI
import CoreLocation

struct BusTimetableView: View {
    var busLine: BusLine
    var busStop: BusStop
    
    @State private var userLocation: CLLocation?
    @State private var shareText: String = ""
    @State private var selectedTimeIndex: Int?

    var body: some View {
        VStack {
            if let userLocation = userLocation, let busStopLocation = busStop.location {
                let distanceInMeters = userLocation.distance(from: busStopLocation)
                let distanceInKilometers = Measurement(value: distanceInMeters, unit: UnitLength.meters).converted(to: .kilometers).value
                let roundedDistance = String(format: "%.2f", distanceInKilometers)
                let timeDistance = Int(distanceInMeters/70)
                
                
                VStack {
                    Text("Distance to bus stop: \(roundedDistance) kilometers")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    Text("It will take around \(timeDistance) minutes to get there")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
            } else {
                Text("Loading...")
            }
            
            ZStack {
                List {
                    if let timetable = busStop.timetable {
                        ForEach(timetable.indices, id: \.self) { index in
                            let time = timetable[index]
                            if let currentTime = currentTimeAsInt(), currentTime < time {
                                VStack(alignment: .leading) {
                                    Button(action: {
                                        self.shareText = "I'm catching the bus number \(self.busLine.number) at \(formatTime(time)) from \(self.busStop.name ?? "")."
                                        self.selectedTimeIndex = index
                                    }) {
                                        Text(formatTime(time))
                                            .foregroundColor(self.selectedTimeIndex == index ? .blue : .primary)
                                    }
                                }
                            }
                        }
                    } else {
                        Text("No timetable available")
                            .foregroundColor(.gray)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("\(busLine.number ??  0) - \(busStop.name ?? "")⏰")
                                .font(.largeTitle)
                                
                        }
                    }
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
            if let firstTime = busStop.timetable?.first {
                self.shareText = "I'm catching the bus number \(busLine.number) at \(formatTime(firstTime)) from \(busStop.name)."
            }
        }
    }
}



