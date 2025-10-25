//
//  DetailView.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import SwiftUI
import Combine

struct MovieDetailView: View {
    @StateObject private var vm: MovieDetailViewModel
    @Environment(\.dismiss) private var dismiss
    init(movieId: Int) { _vm = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId)) }

    var body: some View {
        ScrollView {
            if vm.movieDetailModel != nil {
                VStack(alignment: .leading, spacing: 12) {
                    if let video = vm.movieDetailModel?.trailerVideo {
                        Link(destination: URL(string: "https://www.youtube.com/watch?v=\(video.key)")!) {
                            ZStack {
                                AsyncImage(url: Endpoints.imagePath(path: vm.movieDetailModel?.moveDetail.backdrop_path ?? "")) { phase in
                                    switch phase {
                                    case .empty: ProgressView()
                                    case .success(let image): image.resizable().scaledToFit()
                                    case .failure: Image(systemName: "photo")
                                    @unknown default: EmptyView()
                                    }
                                }
                                Image(systemName: "play.circle.fill").font(.system(size: 64))
                            }
                            .frame(height: 200)
                        }
                    }
                    
                    Text(vm.movieDetailModel?.moveDetail.title ?? "-").font(.title).bold()
                    HStack {
                        Text("⭐️ \(String(format: "%.1f", vm.movieDetailModel?.moveDetail.vote_average ?? 0))")
                        Spacer()
                        Text((vm.movieDetailModel?.moveDetail.runtime != nil) ? "\(vm.movieDetailModel!.moveDetail.runtime!) min" : "—")
                    }
                    
                    Text("Genres: \(vm.movieDetailModel?.moveDetail.genres.map { $0.name }.joined(separator: ", ") ?? "—")")
                        .font(.subheadline)
                    Divider()
                    Text(vm.movieDetailModel?.moveDetail.overview ?? "No overview")
                    
                    Button(action: vm.toggleFavorite) {
                        HStack {
                            Image(systemName: vm.isFavorite() ? "heart.fill" : "heart")
                            Text(vm.isFavorite() ? "Unfavorite" : "Add to Favorites")
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .overlay {
            if vm.isLoading {
                ProgressView()
            }
        }
        .alert(vm.alertTitle, isPresented: $vm.showAlert) {
            Button("OK") { dismiss() }
        } message: {
            Text(vm.errMsg)
        }
    }
}
