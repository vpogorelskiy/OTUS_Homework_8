import Foundation
import SwiftUI
import MoviesApi

enum ViewBuilder {
    private static var moviesApi = MoviesAPI()
    static var browseMoviesView: some View {
        MoviesView()
            .environmentObject(MoviesViewModel(moviesApi: moviesApi) as BaseViewModel)
    }
    
    static var favoriteMoviesView: some View {
        MoviesView()
            .environmentObject(FavoritesViewModel(moviesApi: moviesApi) as BaseViewModel)
    }
}
