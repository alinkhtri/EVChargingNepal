//
//  HomeView.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @State private var searchText: String = ""
    @EnvironmentObject private var localSearchService: LocalSearchService
    
    var body: some View {
        NavigationView {
            MapView()
        }
        .searchable(text: $searchText, prompt: "Search charging stations")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocalSearchService())
    }
}

