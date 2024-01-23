//
//  DetailView.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 20/08/2023.
//

import SwiftUI

struct ChargingStationDetailView: View {
    
    // MARK: - Properties
    @ObservedObject var mapViewModel: MapViewModel
    @State var currentType: String = "Info"
    @Namespace var animation
    @Environment(\.presentationMode) var presentationMode
    
    struct Amenity {
            let name: String
            let icon: String
        }

        let amenities: [Amenity] = [
            Amenity(name: "wifi", icon: "wifi"),
            Amenity(name: "restroom", icon: "figure.dress.line.vertical.figure"),
            Amenity(name: "parking", icon: "parkingsign.circle"),
            Amenity(name: "restaurant", icon: "fork.knife.circle"),
            Amenity(name: "lounge", icon: "figure.stand"),
        ]
    
    var safeArea: EdgeInsets
    var size: CGSize
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading){
                // MARK: - Artwork
                Image("Header2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)

                VStack {

                    VStack(alignment: .leading) {
                        Text(mapViewModel.selectedChargingStation?.name ?? "Dummy location Name")
                            .font(.title3)
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
                        
                        HStack(alignment: .bottom) {
                            Text("5.0")
                                .font(.footnote)
                            
                            HStack(spacing: 0) {
                                ForEach(1...5, id: \.self) { index in
                                    Image(systemName: index <= 5 ? "star.fill" : "star")
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
                        //                        .padding(5)
                        
                    }
                    .padding(.top)
                    .padding()
                    HStack {
                        ForEach(mapViewModel.actions) { action in
                            Button {
                                action.handler()
                            } label: {
                                VStack(spacing: 5) {
                                    Image(systemName: action.image)
                                        .foregroundColor(.accentColor)
                                    Text(action.title)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.accentColor)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                }
                .padding(.bottom)
                
                // Since We ignored Top Edge
                GeometryReader{ proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                    
                    PinnedHeaderView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: minY < 50 ? -(minY - 50) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .fontWeight(.medium)

                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Fusce hendrerit mauris vitae ex ullamcorper, vel feugiat libero suscipit. Proin eleifend augue non metus venenatis, vel tincidunt nisi eleifend. Vivamus tristique justo in fermentum sagittis. Sed eu odio nec justo cursus tincidunt.")
                            .font(.callout)
                                .foregroundColor(.gray)
                                .lineLimit(3)
                    }
                    Divider()
                    HStack {
                        HStack {
                                Image(systemName: "ev.plug.ac.type.2")
                                    .foregroundColor(Color.gray)
                            Image(systemName: "ev.plug.dc.ccs2")
                                .foregroundColor(Color.gray)
                            Image(systemName: "ev.plug.dc.ccs1")
                                .foregroundColor(Color.gray)
                            
                        }
                        Spacer()
                        HStack {
                            
                            Text("3 chargers")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(.accentColor)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 15))
                                .foregroundColor(.accentColor)
                        }
                    }
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Amenities")
                            .fontWeight(.medium)
                        
                        HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        ForEach(amenities.prefix(3), id: \.name) { amenity in
                                            amenityRow(amenity: amenity)
                                        }
                                    }
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 8) {
                                        ForEach(amenities.dropFirst(3).prefix(2), id: \.name) { amenity in
                                            amenityRow(amenity: amenity)
                                        }
                                    }
                                }
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func amenityRow(amenity: Amenity) -> some View {
            HStack {
                Image(systemName: amenity.icon)
                    .foregroundColor(.green)
                Text(amenity.name.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    
    @ViewBuilder
    func PinnedHeaderView() -> some View{
        let types: [String] = ["Info","Chargers","Check-ins","Reviews","More"]
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25){
                ForEach(types,id: \.self){ type in
                    VStack(spacing: 12){
                        Text(type)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(currentType == type ? .accentColor : .gray)
                        
                        ZStack{
                            if currentType == type{
                                Capsule()
                                    .fill(Color.accentColor)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                            else{
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.clear)
                            }
                        }
                        .frame(height: 4)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            currentType = type
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .padding(.top)
            .frame(height: 47.0)
        }
    }
    
    @ViewBuilder
    func Artwork() -> some View {
        let height = size.height * 0.45
        GeometryReader{ proxy in
            
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            Image("Header2")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0 ))
//                .clipped()
//                .overlay(content: {
//                    ZStack(alignment: .bottom) {
//
//                        // MARK: - Gradient Overlay
//                        Rectangle()
//                            .fill(
//                                .linearGradient(colors: [
//                                    //                                    Color(.systemBackground).opacity(0 - progress),
//                                    //                                    Color(.systemBackground).opacity(0 - progress),
//                                    //                                    Color(.systemBackground).opacity(0 - progress),
//                                    Color(.systemBackground).opacity(0),
//                                    Color(.systemBackground).opacity(1),
//                                ], startPoint: .center, endPoint: .bottom)
//                            )
//                    }
//                })
//                .offset(y: -minY)
            
            
        }
        .frame(height: height*0.5 + safeArea.top )
    }
    
    
    // MARK: - Header View
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader{ proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress =  minY / height
            
            HStack(spacing: 15) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Circle()
                                .foregroundColor(Color.secondary.opacity(0.7))
                        )
                }
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Circle()
                                .foregroundColor(Color.secondary.opacity(0.7))
                        )
                }
                .opacity(1 + progress)
                
                Menu {
                    Button {
                        //                        menuTapped()
                    } label: {
                        HStack {
                            Text("Share")
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                        }
                    }
                    
                    Button("Option", action: menuTapped)
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Circle()
                                .foregroundColor(Color.secondary.opacity(0.7))
                        )
                }
            }
            .overlay(content: {
                Text(mapViewModel.selectedChargingStation?.name ?? "Charging Station")
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0.80 ? 0 : 45)
                    .clipped()
                    .animation(.easeOut(duration: 0.25), value: -titleProgress > 0.80)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal,.bottom], 15)
            .background(
                Color(.systemBackground)
                    .opacity(-progress > 1 ? 1 : 0)
            )
            .offset(y: -minY)
            
            
            
        }
        .frame(height: 35)
    }
    
    func menuTapped() {
        
    }
}

struct ChargingStationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

