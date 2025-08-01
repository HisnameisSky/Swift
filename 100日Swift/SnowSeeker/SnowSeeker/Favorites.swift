//
//  Favorites.swift
//  SnowSeeker
//
//  Created by 澄界 on 2025/08/01.
//

import Foundation

//[.](:.)お気に入りの設定
class Favorites: ObservableObject {
    
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    //classの構造体なので起動の機能を加える
    init() {
        
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        resorts = []
    }
    //さまざまな機能
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
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
