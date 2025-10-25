//
//  ContentView.swift
//  MovieDB
//
//  Created by JAYA$URYA on 25/10/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Movies", systemImage: "house")
            }
        }
    }
}

#Preview {
    MainTabView()
}
