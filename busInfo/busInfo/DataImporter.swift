//
//  DataImporter.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import Foundation
import Firebase

class DataImporter {
    let db = Firestore.firestore()
    
    let busLinesData = [
        ["number": 1],
        ["number": 2]
    ]
    
    let stopsData = [
        ["name": "Stop A", "timetable": ["8:00", "9:00", "10:00"]],
        ["name": "Stop B", "timetable": ["8:15", "9:15", "10:15"]],
        ["name": "Stop C", "timetable": ["8:30", "9:30", "10:30"]],
        ["name": "Stop X", "timetable": ["8:00", "9:00", "10:00"]],
        ["name": "Stop Y", "timetable": ["8:15", "9:15", "10:15"]],
        ["name": "Stop Z", "timetable": ["8:30", "9:30", "10:30"]]
    ]
    
    func addBusLines() {
        for data in busLinesData {
            db.collection("TestBusLines").addDocument(data: data) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Bus line added successfully")
                }
            }
        }
    }
    
}

