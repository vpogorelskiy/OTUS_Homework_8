import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                ViewBuilder.browseMoviesView
            }
            .tabItem{
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
            NavigationView {
                ViewBuilder.favoriteMoviesView
            }
            .tabItem{
                Image(systemName: "star.fill")
                Text("Favorites")
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
