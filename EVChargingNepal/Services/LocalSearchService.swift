//
//  LocalSearchService.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import SwiftUI
import Foundation
import MapKit
import Combine

@MainActor
class LocalSearchService: ObservableObject {
    
    @Published var region: MKCoordinateRegion
    @Published var searchResults: [SearchResultItem] = []
    @Published var showSearchResults: Bool = false
    @Published var selectedResult: SearchResultItem?
    
    let locationManager = LocationManager()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.region = MKCoordinateRegion.defaultRegion()
        locationManager.$region.assign(to: \.region, on: self)
            .store(in: &cancellables)
    }
    
    func searchLocation(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = locationManager.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            print(response)
            
            DispatchQueue.main.async {
                let mapItems = response.mapItems
                self.toggleShowResults()
                self.searchResults = mapItems.map {
                    SearchResultItem(placemark: $0.placemark)
                }
                
            }
        }
    }
    
    func toggleShowResults() {
        withAnimation {
            showSearchResults.toggle()
        }
    }
}
