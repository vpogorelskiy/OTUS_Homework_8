//
//  ContentView.swift
//  Shared
//
//  Created by Вячеслав Погорельский on 16.12.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MoviesViewModel()
    
    var body: some View {
        TabView {
            List {
                ForEach(viewModel.movies) { item in
                    NavigationLink {
                        Text(item.title)
                            .navigationTitle(item.title)
                    } label: {
                        HStack {
                            if let urlString = item.imageUrl,
                                let url = URL(string: urlString) {
                                AsyncImage(url: url)
                            }
                            Text(item.title)
                        }
                    }
                }
            }
            .tabItem{
                Text("Browse")
            }
            Text("Favorites")
                .tabItem{
                    Text("Favorites")
                }
            Text("Settings")
                .tabItem{
                    Text("Settings")
                }
        }.onAppear {
            viewModel.getMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
