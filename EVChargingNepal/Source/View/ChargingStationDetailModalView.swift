//
//  LocationDetailView.swift
//  EVChargingStations
//
//  Created by Alin Khatri on 13/08/2023.
//

import SwiftUI

struct ChargingStationDetailModalView: View {
    
    @ObservedObject var mapViewModel: MapViewModel
    @State private var isDetailViewPresented = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: GeometryReader {
                let safeArea = $0.safeAreaInsets
                let size = $0.size
                ChargingStationDetailView(mapViewModel: mapViewModel, safeArea: safeArea, size: size)
                    .ignoresSafeArea(.container, edges: .top)
            }
                .navigationBarBackButtonHidden()
                           ,
                           isActive: $mapViewModel.isChargingStationDetailShowing) {
                EmptyView()
            }
            
            
            VStack {
                //                Button {
                //                    mapViewModel.isChargingStationShowing.toggle()
                //                } label: {
                //                    Image(systemName: "xmark.circle.fill")
                //                        .foregroundColor(.secondary)
                //                }
                //                .frame(maxWidth: .infinity, alignment: .trailing)
                //                .padding(.horizontal, 5)
                //                .padding(.vertical, 5)
                HStack {
                    VStack(alignment: .leading) {
                        Text(mapViewModel.selectedChargingStation?.name ?? "Dummy location Name")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        
                        
                        HStack {
                            Image("location")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(mapViewModel.selectedChargingStation?.address ?? "Dummy Address Name")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        mapViewModel.actions.first?.handler()
                    } label: {
                        Image("direction")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
                
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.accentColor)
                    
                    Text(mapViewModel.selectedChargingStation?.telephone ?? "N/A")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
                
                HStack(alignment: .center) {
                    Text("5.0")
                        .font(.footnote)
                    
                    HStack(spacing: 0) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= 5 ? "star.fill" : "star")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    // Review Count
                    Text("(\(106) reviews)")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    Spacer()
                }
                .padding(.vertical, 1)
                
                VStack {
                    Divider()
                    HStack {
                        HStack {
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 15))
                                .foregroundColor(.accentColor)
                            
                            Text(mapViewModel.selectedChargingStation?.plugs?.first?.power ?? "7.2Kw")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 15))
                                .foregroundColor(.accentColor)
                            
                            Text("50/Kw")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "figure.run")
                                .font(.system(size: 15))
                                .foregroundColor(.accentColor)
                            
                            Text("2.5km")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                        }
                    }
                    Divider()
                }
                .padding(.vertical, 8)
//                VStack {
//                    Divider()
//                    HStack {
//                        ForEach(mapViewModel.actions) { action in
//                            Button {
//                                action.handler()
//                            } label: {
//                                VStack(spacing: 5) {
//                                    Image(systemName: action.image)
//                                        .foregroundColor(.accentColor)
//                                    Text(action.title)
//                                        .font(.subheadline)
//                                        .fontWeight(.medium)
//                                        .foregroundColor(Color.accentColor)
//                                }
//                                .frame(maxWidth: .infinity)
//                            }
//                            .buttonStyle(.bordered)
//                        }
//                    }
//                    Divider()
//                }
                HStack(spacing: 10) {
                    Button {
                        mapViewModel.toggleShowChargingStationDetail()
                    } label: {
                        Text("View")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                    
                    Button {
                        // Button action
                    } label: {
                        Text("Book")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .cornerRadius(100)
                }
//                .padding(.vertical, 8)
            }
            .padding()
            .background(Color("Secondary"))
            .cornerRadius(12)
            .frame(width: min(UIScreen.main.bounds.width-20, 500))

                
        }
        .padding(15)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingStationDetailModalView(mapViewModel: MapViewModel())
            .previewLayout(.sizeThatFits)
    }
}
