//
//  Favorites.swift
//  SnowSeeker
//
//  Created by ramsayleung on 2024-04-08.
//

import SwiftUI

@Observable
class Favorites {
    let savePath = URL.documentsDirectory.appending(path: "savedFavorites")
    private var resorts: Set<String>
    
    private let key = "Favorites"
    
    init() {
        // load our saved data
        do {
            let data = try Data(contentsOf: savePath)
            resorts =  try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath)
        }catch {
            print("Unable to save data.")
        }
    }
}
