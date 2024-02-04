//
//  Utilities.swift
//  busInfo
//
//  Created by Kamil Golawski on 03/02/2024.
//

import Foundation
import CoreLocation



func formatTime(_ time: Int) -> String {
    let hours = time / 100
    let minutes = time % 100
    return "\(hours):\(minutes)"
}

func currentTimeAsInt() -> Int? {
    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date)
    return (components.hour ?? 0) * 100 + (components.minute ?? 0)
}

