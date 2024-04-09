//
//  ResortView.swift
//  SnowSeeker
//
//  Created by ramsayleung on 2024-04-07.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("Photo by " + resort.imageCredit)
                        .font(.caption)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.primary.opacity(0.1))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large{
                        VStack {
                            ResortDetailsView(resort: resort)
                        }
                        VStack {
                            SkiDetailsView(resort: resort)
                        }
                    } else{
                        
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(resort){
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility){_ in
        } message: {facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: Resort.example)
        .environment(Favorites())
}
