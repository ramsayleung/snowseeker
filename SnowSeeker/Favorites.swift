//
//  Favorites.swift
//  SnowSeeker
//
//  Created by ramsayleung on 2024-04-08.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    
    private let key = "Favorites"
    
    init() {
        // load our saved data
        
        resorts = []
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
    }
}
