//
//  MapView.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 13/08/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var searchText: String = ""
    
    @EnvironmentObject private var localSearchService: LocalSearchService
    @StateObject var chargingStationViewModel = MapViewModel()
    
    private func unfocusTextField() {
            // Resign the first responder to dismiss the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: chargingStationViewModel.chargingStations) { annotation in
                    
                    
                    MapAnnotation(coordinate: annotation.coordinate) {
                        mapMarker()
                            .onTapGesture {
                                
                                withAnimation {
                                    localSearchService.region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                                    chargingStationViewModel.setSelectedChargingStation(for: annotation)
                                }
                            }
                    }
                }
                .accentColor(.accentColor)
                .onTapGesture {
                    localSearchService.showSearchResults ? localSearchService.toggleShowResults() : nil
                    unfocusTextField()
                }
                .edgesIgnoringSafeArea(.all)
                
                
                VStack() {
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("Search stations", text: $searchText)
                            .textFieldStyle(.plain)
                            .font(.body)
                            .frame(height: 55)
                            .padding(.leading, 30)
                            .overlay(alignment: .leading) {
                                Image(systemName: "magnifyingglass")
                                    .font(.body)
                                    .foregroundColor(.accentColor).opacity(0.8)
                            }
                            .onChange(of: searchText, perform: { newValue in
                                if newValue.isEmpty { return }
                                localSearchService.searchLocation(query: newValue)
                            })
                            .onSubmit {
                                if searchText.isEmpty { return }
                                chargingStationViewModel.toggleShowChargingStation()
                                localSearchService.searchLocation(query: searchText)
                            }
                        
                        if localSearchService.showSearchResults {
                            ForEach(localSearchService.searchResults, id: \.self) { item in
                                VStack {
                                    Button {
                                        withAnimation {
                                            searchText = ""
                                            localSearchService.region = MKCoordinateRegion(center: item.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                                            localSearchService.toggleShowResults()
                                            unfocusTextField()
                                        }
                                        
                                    } label: {
                                        VStack(alignment: .leading) {
                                            Text(item.name)
                                                .font(.headline)
                                                .fontWeight(.medium)
                                            Text(item.title)
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                            Divider()
                                        }
                                    }
                                }
                                .padding(.vertical)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(.primary)
                    .frame(width: min(UIScreen.main.bounds.width-20, 500))
                    .background(Color("Secondary"))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    
                    if chargingStationViewModel.isChargingStationShowing {
                        ChargingStationDetailModalView(mapViewModel: chargingStationViewModel)
                            .backgroundStyle(.background)
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocalSearchService())
    }
}

extension MapView {
    private func homeOption(title: String, image: String) -> some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.54))
            Image(systemName: image)
                .foregroundColor(Color(red: 0.42, green: 0.46, blue: 0.54))
        }
        .padding(.horizontal, 5)
        .padding(20)
        .background(.background)
        .cornerRadius(12)
    }
    
    private func mapMarker() -> some View {
        VStack(spacing: 0) {
            Image(systemName: "bolt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 17, height: 17)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.accentColor)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
        
    }
    
}
