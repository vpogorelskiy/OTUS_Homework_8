import SwiftUI
import MoviesApi

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                ViewBuilder.browseMoviesView
                    .tabItem{
                        Text("Browse")
                    }
                ViewBuilder.favoriteMoviesView
                    .tabItem{
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
