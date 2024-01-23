//
//  MKCoordinateRegion+Extensions.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 27.707355, longitude: 85.326268), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    
    static func regionFromSuggestion(_ suggestion: SearchResultItem) -> MKCoordinateRegion {
        MKCoordinateRegion(center: suggestion.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
