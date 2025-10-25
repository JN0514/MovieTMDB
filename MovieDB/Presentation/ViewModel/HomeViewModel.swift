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
    private var popularMoviesPageno = 1
    private var popularMovies: [Movie] = []
    
    private var searchMoviesPageno = 1
    private var searchMovies: [Movie] = []
    
    @Published var isLoading = false
    var alertTitle = ""
    var errMsg = ""
    @Published var showAlert = false

    @Published var favorites: Set<Int> = []

    @Published var searchTxt = ""
    
    private let repository: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
        self.favorites = FavoritesStore.shared.load()

        $searchTxt
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] search in
                self?.searchMoviesPageno = 1
                self?.previousRequestedPageNo = 0
                self?.searchOrLoad(search)
            }
            .store(in: &cancellables)
        
        loadPopularMovies()
    }
    
    func retryRequest() {
        showAlert = false
        if searchTxt.isEmpty {
            loadPopularMovies()
        } else {
            searchMovies(searchTxt)
        }
    }
    
    private var previousRequestedPageNo = 0
    func loadPopularMovies() {
        previousRequestedPageNo = popularMoviesPageno
        isLoading = true
        repository.getPopular(pageNo: popularMoviesPageno)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.alertTitle = "Failed to fetch movies"
                    self?.errMsg = err.localizedDescription
                    self?.showAlert = true
                }
            }, receiveValue: { [weak self] movies in
                self?.popularMovies.append(contentsOf: movies)
                self?.movies = self?.popularMovies ?? []
                if !movies.isEmpty {
                    self?.popularMoviesPageno += 1
                }
            })
            .store(in: &cancellables)
    }
    
    private func searchOrLoad(_ searchStr: String) {
        if searchStr.isEmpty {
            movies = popularMovies
            return
        }
        searchMovies(searchStr)
    }
    
    func searchOrLoadForPagingation() {
        if searchTxt.isEmpty {
            guard previousRequestedPageNo != popularMoviesPageno else { return }
            loadPopularMovies()
        } else {
            guard previousRequestedPageNo != searchMoviesPageno else { return }
            searchMovies(searchTxt)
        }
    }
    
    private func searchMovies(_ searchStr: String) {
        previousRequestedPageNo = searchMoviesPageno
        isLoading = true
        repository.search(searchQuery: searchStr, pageNo: searchMoviesPageno)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.alertTitle = "Failed to search movies"
                    self?.errMsg = err.localizedDescription
                    self?.showAlert = true
                } else {
                    self?.searchMoviesPageno += 1
                }
            }, receiveValue: { [weak self] movies in
                self?.searchMovies.append(contentsOf: movies)
                self?.movies = self?.searchMovies ?? []
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
