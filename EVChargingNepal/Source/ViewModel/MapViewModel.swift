//
//  MapViewModel.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    
    @Published var chargingStations: [EVChargingStationItem] = []
    @Published var isChargingStationShowing = false
    @Published var isChargingStationDetailShowing = false
    @Published private(set) var selectedChargingStation: EVChargingStationItem?
    @Published private(set) var actions = [Action]()
    
    init() {
        createActions()
        decodeJSONFromFile()
    }
    
    func toggleShowChargingStationDetail() {
        withAnimation {
            isChargingStationDetailShowing.toggle()
        }
    }
    
    func toggleShowChargingStation() {
        withAnimation {
            isChargingStationShowing.toggle()
        }
    }
    
    func decodeJSONFromFile() {
        guard let jsonURL = Bundle.main.url(forResource: "EVChargingStationData", withExtension: "json") else {
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            self.chargingStations = try decoder.decode([EVChargingStationItem].self, from: jsonData)
            print(chargingStations)
        } catch {
            print("Error decoding JSON from file: \(error)")
        }
    }
    
    func openMap(coordinate: CLLocationCoordinate2D) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.openInMaps()
    }
    
    func setSelectedChargingStation(for chargingStation: EVChargingStationItem) {
        selectedChargingStation = chargingStation
        withAnimation(.easeInOut) {
            if isChargingStationShowing { return }
            isChargingStationShowing.toggle()
        }
    }
    
    func createActions() {
        actions = [
            Action(title: "Directions", image: "car.fill", handler: { [weak self] in
                guard let self = self else { return }
                self.openMap(coordinate: self.selectedChargingStation!.coordinate)
            }),
            Action(title: "Call", image: "phone.fill", handler: { [weak self] in
                guard let self = self else { return }
                guard let phoneNumber = self.selectedChargingStation?.telephone else { return }
                guard let url = URL(string: self.convertPhoneNumberFormat(phoneNumber: phoneNumber)) else { return }
                UIApplication.shared.open(url)
            }),
            Action(title: "Website", image: "safari.fill", handler: {
                return
            })
        ]
    }
    
    func convertPhoneNumberFormat(phoneNumber: String) -> String {
        let strippedPhoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        return "tel//\(strippedPhoneNumber)"
    }
}
