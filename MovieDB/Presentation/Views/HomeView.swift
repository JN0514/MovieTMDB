//
//  HomeView.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//


import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        List {
            if !vm.isLoading && vm.movies.isEmpty {
                Text("No movies found")
                    .foregroundColor(.gray)
                    .italic()
                    .padding()
            } else {
                Section() {
                    ForEach(vm.movies) { movie in
                        NavigationLink {
                            VStack {
                                Text("Video Detail View")
                            }
                        } label: {
                            MovieRowView(movie: movie, isFav: vm.isFavorite(movieId: movie.id)) {
                                vm.toggleFavorite(movieId: movie.id)
                            }
                        }
                    }
                    .listSectionSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Popular Movies")
        .overlay(Group {
            if vm.isLoading { ProgressView() }
        })
        .alert(vm.alertTitle, isPresented: $vm.showAlert) {
            Button("Okay", role: .cancel) {}
        } message: {
            Text(vm.errMsg)
        }
        
    }
}
