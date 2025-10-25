//
//  FavoritesStore.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import Foundation

class FavoritesStore {
    private let key = "favorites"
    private let defaults = UserDefaults.standard

    static let shared = FavoritesStore()
    private init() {}

    func load() -> Set<Int> {
        guard let data = defaults.data(forKey: key) else { return [] }
        do {
            let arr = try JSONDecoder().decode([Int].self, from: data)
            return Set(arr)
        } catch {
            return []
        }
    }

    func save(_ set: Set<Int>) {
        let arr = Array(set)
        if let data = try? JSONEncoder().encode(arr) {
            defaults.set(data, forKey: key)
        }
    }
}
