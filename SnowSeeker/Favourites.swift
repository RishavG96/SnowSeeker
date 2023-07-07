//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Rishav Gupta on 07/07/23.
//

import Foundation

class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let data = try Data(contentsOf: saveKey)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: saveKey, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}
