//
//  BusViewModel.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import Foundation
import FirebaseFirestore
import CoreLocation
 
class BusViewModel: ObservableObject {
     
    @Published var busLines = [BusLine]()
     
    private var database = Firestore.firestore()
     
    func fetchData() {
        database.collection("BusLines").addSnapshotListener { (querySnapshot, error) in
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
                        if let name = subDocument.data()["NameOfStop"] as? String,
                           let timeArray = subDocument.data()["TimeTable"] as? [Int],
                           let geoPoint = subDocument.data()["Location"] as? GeoPoint {
                            let location = CLLocation(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                            stops.append(BusStop(name: name, timetable: timeArray, location: location))
                        }
                    }
                    tempBusLines.append(BusLine(number: number, stops: stops))
    
                    DispatchQueue.main.async {
                        self.busLines = tempBusLines
                    }
                }
            }
        }
    }


}


