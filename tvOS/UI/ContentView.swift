import SwiftUI
import MoviesApi

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                ViewBuilder.browseMoviesView
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                        Text("Browse")
                    }
                ViewBuilder.favoriteMoviesView
                    .tabItem{
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MockViewModel())
    }
}
