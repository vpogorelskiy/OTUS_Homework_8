import SwiftUI
import MoviesApi

@main
struct OTUS_Homework_8App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MoviesViewModel(moviesApi: MoviesAPI()))
        }
    }
}
