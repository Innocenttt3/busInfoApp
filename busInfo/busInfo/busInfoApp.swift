//
//  busInfoApp.swift
//  busInfo
//
//  Created by Kamil Golawski on 01/02/2024.
//

import SwiftUI
import Firebase
import CoreLocation

@main
struct busInfoApp: App {
    
    init() {
       FirebaseApp.configure()
       }

    var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
}


