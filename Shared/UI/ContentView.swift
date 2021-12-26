//
//  ContentView.swift
//  Shared
//
//  Created by Вячеслав Погорельский on 16.12.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoviesView(viewModel: MoviesViewModel())
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
