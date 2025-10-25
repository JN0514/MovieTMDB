//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetailModel: MovieDetailModel?
    @Published var isLoading = false
    var alertTitle = ""
    var errMsg = ""
    @Published var showAlert = false
    @Published var favorites: Set<Int> = []

    private let repo: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    let movieId: Int

    init(movieId: Int, repo: MovieRepositoryProtocol = MovieRepository()) {
        self.movieId = movieId
        self.repo = repo
        self.favorites = FavoritesStore.shared.load()
        loadDetailResponse()
    }

    func loadDetailResponse() {
        isLoading = true
        let detailPub = repo.getDetail(movieId: movieId)
        let videosPub = repo.getVideos(movieId: movieId)
        let castsPub = repo.getCasts(movieId: movieId)

        Publishers.Zip3(detailPub, videosPub, castsPub)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.alertTitle = "Failed to fetch Movie Details"
                    self?.errMsg = err.localizedDescription
                    self?.showAlert = true
                }
            }, receiveValue: { [weak self] detail, videos, casts in
                let video = videos.first(where: { $0.type == "Trailer" }) ?? videos.first
                self?.movieDetailModel = MovieDetailModel(moveDetail: detail, castList: casts, trailerVideo: video)
            })
            .store(in: &cancellables)
    }

    func toggleFavorite() {
        if favorites.contains(movieId) { favorites.remove(movieId) } else { favorites.insert(movieId) }
        FavoritesStore.shared.save(favorites)
    }

    func isFavorite() -> Bool { favorites.contains(movieId) }
}
