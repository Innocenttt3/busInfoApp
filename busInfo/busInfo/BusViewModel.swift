import Foundation
import FirebaseFirestore
import CoreLocation
 
class BusViewModel: ObservableObject {
     
    @Published var busLines = [BusLine]()
     
    private var database = Firestore.firestore()
     
    func fetchData() {
        database.collection("BusLines")
            .order(by: "NumberOfBus", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            var tempBusLines = [BusLine]()

            for document in documents {
                let data = document.data()
                let number = data["NumberOfBus"] as? Int ?? 0
                var stops = [BusStop]()

                let busLineRef = self.database.collection("BusLines").document(document.documentID)
                busLineRef.collection("Stops").getDocuments { (subQuerySnapshot, error) in
                    guard let subDocuments = subQuerySnapshot?.documents else {
                        print("No subdocuments")
                        return
                    }

                    for subDocument in subDocuments {
                        let name = subDocument.data()["NameOfStop"] as? String ?? ""
                        let timeArray = subDocument.data()["TimeTable"] as? [Int] ?? []
                        let geoPoint = subDocument.data()["Location"] as? GeoPoint
                        let index = subDocument.data()["Index"] as? Int
                        let location = geoPoint != nil ? CLLocation(latitude: geoPoint!.latitude, longitude: geoPoint!.longitude) : nil
                        stops.append(BusStop(name: name, timetable: timeArray, location: location, index: index))
                    }
                    let sortedStops = stops.sorted { $0.index ?? Int.max < $1.index ?? Int.max }
                    tempBusLines.append(BusLine(number: number, stops: sortedStops))
                    DispatchQueue.main.async {
                       
                        self.busLines = tempBusLines.sorted(by: { $0.number < $1.number })
                    }
                }
            }
        }
    }



}


