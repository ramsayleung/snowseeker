//
//  ContentView.swift
//  SnowSeeker
//
//  Created by ramsayleung on 2024-04-06.
//

import SwiftUI

enum SortingOrder {
    case defaultOrder
    case alphaOrder
    case countryOrder
}

struct ContentView: View {
    let resorts : [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortOrder = SortingOrder.defaultOrder
    
    var sortedResort: [Resort] {
        switch sortOrder {
        case .defaultOrder:
            return resorts
        case .alphaOrder:
            return resorts.sorted { a, b in
                a.name < b.name
            }
        case .countryOrder:
            return resorts.sorted { a, b in
                a.country < b.country
            }
        }
    }
    
    var filteredResort: [Resort] {
        if searchText.isEmpty {
            return sortedResort
        } else{
            return sortedResort.filter {$0.name.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResort) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }.navigationTitle("Resorts")
             .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
             .searchable(text: $searchText, prompt: "Search for a resort")
             .toolbar {
                 ToolbarItem(placement: .topBarTrailing){
                     Menu("Sort by", systemImage: "arrow.up.arrow.down"){
                         Picker("Order", selection: $sortOrder){
                             Text("Sort by Alphabetical")
                                 .tag(
                                    SortingOrder.alphaOrder
                                 )
                             Text("Sort by Country")
                                 .tag(
                                    SortingOrder.countryOrder
                                 )
                             Text("Sort by Default")
                                 .tag(
                                    SortingOrder.defaultOrder
                                 )
                         }
                     }
                 }
             }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
