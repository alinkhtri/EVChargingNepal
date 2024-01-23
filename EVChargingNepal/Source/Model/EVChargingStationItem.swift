//
//  EVChargingStation.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import Foundation
import CoreLocation

enum VehicleType: String, Codable {
    case car
    case bike
}

enum Amenity: String, Codable {
    case wifi
    case parking
    case food
    case coffee
    case accommodation
    case restroom
}


struct EVChargingStationItem: Identifiable, Codable {
    var id: String {
        name + city
    }
    let name: String
    let city: String
    let province: String?
    let address: String
    let telephone: String?
    let type: [String]
    let latitude: String
    let longitude: String
    let plugs: [Plug]?
    let amenities: [String]?
    
    var coordinate: CLLocationCoordinate2D {
            guard let lat = CLLocationDegrees(latitude), let lon = CLLocationDegrees(longitude) else {
                return CLLocationCoordinate2D()
            }
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
}

struct Plug: Codable, Hashable {
    let plug: String
    let power: String?
    let type: String?
}

//{
//    "name": "Hotel Barahi",
//    "city": "Pokhara",
//    "province": "3",
//    "address": "Lakeside Rd 6",
//    "telephone": "61460617",
//    "type": ["car"],
//    "latitude": "28.20833041093028",
//    "longitude": "83.95804772177283",
//    "plugs": [
//        {
//            "plug": "type2",
//            "power": "7.2Kw",
//            "type": "AC"
//        }
//    ],
//    "amenities": [
//        "wifi",
//        "parking",
//        "food",
//        "coffee",
//        "accomodation",
//        "restroom"
//    ]
//},
