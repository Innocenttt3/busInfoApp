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


