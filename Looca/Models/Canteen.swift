//
//  Canteen.swift
//  Looca
//
//  Created by FWZ on 08/04/25.
//

import Foundation

struct Canteen: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var image: String
    var openHours: String
    var estimationInMin: Int
    var distanceInMeters: Int
    var atmosphere: String
    var bestDish: String
    var priceRange: String
    var frequency: String
    var tenants: [Tenant]
    var directions: [Direction]
}
