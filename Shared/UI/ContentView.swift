import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            NavigationView {
                ViewBuilder.browseMoviesView
            }
            .tabItem{
                Text("Browse")
            }
            NavigationView {
                ViewBuilder.favoriteMoviesView
            }
            .tabItem{
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
