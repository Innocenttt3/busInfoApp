import Foundation
import CoreLocation

class BusStop: ObservableObject, Identifiable {
    var id = UUID()
    var index: Int?
    var name: String?
    var timetable: [Int]?
    var location: CLLocation?

    init(name: String?, timetable: [Int]?, location: CLLocation?, index: Int?) {
        self.name = name
        self.timetable = timetable
        self.location = location
        self.index = index
    }
}

