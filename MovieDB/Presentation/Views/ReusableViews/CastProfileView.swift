//
//  CastProfileView.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import SwiftUI

struct CastProfileView: View {
    let cast: Cast
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: Endpoints.imagePath(path: cast.profilePath ?? "")) { phase in
                switch phase {
                case .empty: ProgressView()
                case .success(let image): image.resizable().scaledToFill()
                case .failure: Image(systemName: "person.crop.circle").resizable().scaledToFit()
                @unknown default: EmptyView()
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(.circle)
            Spacer()
            Text(cast.name)
                .font(.caption)
                .lineLimit(2)
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
        }
        .frame(width: 80)
    }
}
