//
//  MovieRowView.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import SwiftUI


struct MovieRowView: View {
    let movie: Movie
    let isFav: Bool
    let toggleFav: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: Endpoints.imagePath(path: movie.posterPath ?? "")) { phase in
                switch phase {
                case .empty: ProgressView()
                case .success(let image): image.resizable().scaledToFit()
                case .failure: Image(systemName: "photo")
                @unknown default: EmptyView()
                }
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title).font(.headline)
                HStack {
                    Text("⭐️ \(String(format: "%.1f", movie.voteAverage ?? 0))")
                    Spacer()
                    Button(action: toggleFav) {
                        Image(systemName: isFav ? "heart.fill" : "heart")
                            .foregroundColor(isFav ? .red : .gray)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
