//
//  SearchResultItem.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import Foundation
import MapKit

struct SearchResultItem: Identifiable, Hashable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
