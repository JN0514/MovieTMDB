//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    var alertTitle = ""
    var errMsg = ""
    @Published var showAlert = false
    @Published var favorites: Set<Int> = []
    
    private let repository: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
        self.favorites = FavoritesStore.shared.load()

        loadPopularMovies()
    }
    
    func loadPopularMovies() {
        isLoading = true
        repository.getPopular()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.alertTitle = "Failed to fetch movies"
                    self?.errMsg = err.localizedDescription
                    self?.showAlert = true
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite(movieId: Int) {
        if favorites.contains(movieId) { favorites.remove(movieId) } else { favorites.insert(movieId) }
        FavoritesStore.shared.save(favorites)
    }

    func isFavorite(movieId: Int) -> Bool { favorites.contains(movieId) }
    
    func updateFavorites() {
        self.favorites = FavoritesStore.shared.load()
    }
}
