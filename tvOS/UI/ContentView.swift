import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                MoviesView()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MockViewModel())
    }
}
