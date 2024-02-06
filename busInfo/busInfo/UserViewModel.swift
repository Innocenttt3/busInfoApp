//
//  UserViewModel.swift
//  busInfo
//
//  Created by Kamil Golawski on 01/02/2024.
//

import Foundation
import Firebase

// Reference to Firestore database
let db = Firestore.firestore()

// Define sample data
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

// Add bus lines to Firestore
func addBusLines() {
    for data in busLinesData {
        db.collection("Bus Lines").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Bus line added successfully")
            }
        }
    }
}

// Add stops to Firestore
func addStops() {
    db.collection("Bus Lines").getDocuments { snapshot, error in
        if let error = error {
            print("Error getting documents: \(error)")
            return
        }
        
        guard let documents = snapshot?.documents else {
            print("No documents")
            return
        }
        
        for document in documents {
            let busLineId = document.documentID
            for data in stopsData {
                db.collection("Bus Lines").document(busLineId).collection("Stops").addDocument(data: data) { error in
                    if let error = error {
                        print("Error adding stop: \(error)")
                    } else {
                        print("Stop added successfully")
                    }
                }
            }
        }
    }
}










