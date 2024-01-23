//
//  EVChargingNepalApp.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import SwiftUI

@main
struct EVChargingNepalApp: App {
    var body: some Scene {
        WindowGroup {
            MapView()
                .environmentObject(LocalSearchService())
        }
    }
}
