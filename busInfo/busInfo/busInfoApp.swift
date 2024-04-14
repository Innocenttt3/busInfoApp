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


