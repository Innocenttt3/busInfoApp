//
//  User.swift
//  busInfo
//
//  Created by Kamil Golawski on 01/02/2024.
//

import Foundation

struct BusLine: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var surname: String
}
