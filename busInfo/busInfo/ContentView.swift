//
//  ContentView.swift
//  busInfo
//
//  Created by Kamil Golawski on 01/02/2024.
//

import SwiftUI
  
 
struct ContentView: View {
    @ObservedObject private var viewModel = BusViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.busLines) { busLine in
                NavigationLink(destination: BusStopsView(busLine: busLine)) {
                    VStack(alignment: .leading) {
                        Text("\(busLine.number)").font(.title)
                    }
                }
            }
            .navigationBarTitle("Bus Lines 🚌")
            .onAppear() {
                self.viewModel.fetchData()
            }
        }
    }
}












