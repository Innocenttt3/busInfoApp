//
//  BusDetailedView.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import SwiftUI

struct BusDetailsView: View {
    let busLine: BusLine
    @ObservedObject private var viewModel = BusDetailsViewModel(busLine: busLine)

    var body: some View {
        List(viewModel.details) { detail in
            VStack(alignment: .leading) {
                Text("\(detail)").font(.title)
            }
        }.navigationBarTitle("\(busLine.number)", displayMode: .inline)
    }
}
