import SwiftUI

struct BusStopsView: View {
    let busLine: BusLine
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Stops for Bus: \(busLine.number) 📍")
                    .font(.largeTitle)
                    .padding(.top, 10)
                
                HStack {
                    Text("Choose your bus stop")
                        .font(.headline)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity) 
                }

                List(busLine.stops) { stop in
                    if let stopName = stop.name {
                        NavigationLink(destination: BusTimetableView(busLine: busLine, busStop: stop)) {
                            Text(stopName)
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .edgesIgnoringSafeArea(.all)
    }
}







 






